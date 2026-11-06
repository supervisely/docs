# Managed Postgres

Sometimes you want to use your own PostgreSQL database instead of the one provided by Supervisely. For example, you may want to use your own database for security reasons or because you already have a PostgreSQL database running in your infrastructure, or you require high availability and fault tolerance.

In this case, you will have to configure Supervisely to use your own database instead of the one provided by default.

Managed Postgres providers examples: Amazon RDS, Google Cloud SQL, Azure Database for PostgreSQL, etc.

### Configuration

To configure Supervisely to use your own database, you will have to edit the `.env` file which you can find in the workdir of your Supervisely installation. You can find the folder by running this command:

```bash
cd $(sudo supervisely where)
```

The `.env` file contains the following lines:

```bash
POSTGRES_DATABASE=clicker
POSTGRES_HOST=postgres
POSTGRES_PASSWORD=<password>
POSTGRES_PORT=5432
POSTGRES_SHM_SIZE=1gb
POSTGRES_SSL=false
POSTGRES_USER=postgres
POSTGRES_VERSION=11.0
```

which is used in `docker-compose.yml` as:

```yaml
POSTGRES_URL: psql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DATABASE}
```

{% hint style="warning" %}
In case you don't have POSTGRES_SSL in your configuration, you will have to [upgrade](../update/upgrade.md) your Supervisely installation to the latest version (at least 6.8.47).
{% endhint %}

You will have to change the values of the variables to match your database configuration. For example, if you are using Amazon RDS, you will have to change the values to something like this:

```bash
POSTGRES_DATABASE=clicker
POSTGRES_HOST=supervisely.123456789012.us-east-1.rds.amazonaws.com
POSTGRES_USER=supervisely
POSTGRES_SSL=true
```

After that you will need to redeploy Supervisely services:

```bash
sudo supervisely up -d
```

In case you get errors or "License not found", please contact Supervisely support and attach the [troubleshoot archive](../troubleshoot/generating_ts_archive.md)

### Database migration

If you're migrating to Amazon RDS you can follow [this guide](https://docs.aws.amazon.com/dms/latest/sbs/chap-manageddatabases.postgresql-rds-postgresql-full-load-pd_dump.html) as well.

In case you already have your valuable data in a local Supervisely database then you will need to transfer it to the new database. The migration is rather simple and can be done in a few steps:

1. Stop Supervisely services and export your local database using `pg_dump`:

```bash
sudo supervisely stop
sudo supervisely start postgres
sudo supervisely exec postgres pg_dump -U postgres -C clicker > supervisely_postgres_dump.sql
```

2. Restore the database dump to your own database:

```bash
PGPASSWORD=your_rds_password psql -h your_rds_endpoint -U your_rds_username -f /path/to/host/supervisely_postgres_dump.sql
```

### Separate user for migrations

By default Supervisely connects to Postgres as a single user: the one that creates and alters tables during an upgrade is also the one every service uses to serve requests. You can split it in two, so that the services run as a read/write user that owns nothing and cannot change the schema:

| User | Configured by | Used by | Needs |
| ---- | ------------- | ------- | ----- |
| Migration user | `POSTGRES_MIGRATIONS_URL` (Helm: `options.postgresMigrationsUrl`) | the migrator during installs and upgrades (schema migrations, data backfills, seeding), and the scheduled `VACUUM` and planner-statistics jobs of `worker-general` | ownership of the Supervisely tables, i.e. the user that has run the migrations so far (`postgres` on the bundled database), and `CREATE` on the schema |
| Service user | `POSTGRES_USER` / `POSTGRES_PASSWORD` (Helm: `options.postgresUser` / `options.postgresPassword`) | `api`, `worker-api`, `worker-general` and every other service | `CONNECT` on the database, `USAGE` on the schema, `SELECT, INSERT, UPDATE, DELETE` on all tables and `USAGE, SELECT, UPDATE` on all sequences |

Leave `POSTGRES_MIGRATIONS_URL` empty to keep using one user for everything; nothing changes for installations that do not set it.

Every migrator run grants the service user the privileges above on all tables and sequences of the schema, and sets default privileges so that tables created by later upgrades are granted as well. The `VACUUM` and planner-statistics jobs need table ownership (as a plain read/write user Postgres skips `VACUUM` with a warning and refuses `ALTER TABLE ... SET STATISTICS`), which is why `worker-general` runs them as the migration user; all other queries of `worker-general` use the service user. The admin **Users overview** refresh runs through a database function owned by the migration user, so it works for the service user too.

1. Create the service user and give it access to the existing tables. Run as the user that owns the tables, replacing `supervisely_app`, the password and `postgres` (the owner) with your values:

```sql
CREATE ROLE supervisely_app LOGIN PASSWORD '<service password>';
GRANT CONNECT ON DATABASE clicker TO supervisely_app;
GRANT USAGE ON SCHEMA public TO supervisely_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO supervisely_app;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO supervisely_app;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO supervisely_app;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO supervisely_app;
```

The migrator applies the same grants on every upgrade; running them once here means the services work as the new user before the next upgrade.

2. Point Supervisely at the two users.

{% tabs %}
{% tab title="Docker Compose" %}
In the `.env` file, set the migration user's full connection URL (the same format as `POSTGRES_URL` above, with your current owner's credentials) and switch `POSTGRES_USER` / `POSTGRES_PASSWORD` to the service user:

```bash
POSTGRES_MIGRATIONS_URL=psql://postgres:<owner password>@<host>:5432/clicker
POSTGRES_USER=supervisely_app
POSTGRES_PASSWORD=<service password>
```

With the bundled database, `POSTGRES_PASSWORD` sets the `postgres` password only when the database is first created, so changing it does not change the owner's password.

Then redeploy the services:

```bash
sudo supervisely up -d
```

The `api` container receives `POSTGRES_MIGRATIONS_URL` too, because upgrades run the migrator as a one-off `api` container; a serving `api` never connects with it.
{% endtab %}

{% tab title="Kubernetes (Helm)" %}
In your values file, set the service user under `options` and give the migration user's URL either as a value or as a reference to a Secret you manage:

```yaml
options:
  postgresUser: supervisely_app
  postgresPassword: <service password>
  postgresMigrationsUrl:
    secretKeyRef:
      name: supervisely-postgres-migrations
      key: url   # psql://postgres:<owner password>@<host>:5432/clicker
```

Then upgrade the release. The migrator Jobs and `worker-general` receive `POSTGRES_MIGRATIONS_URL`; the `api` Deployment does not.
{% endtab %}
{% endtabs %}

If you add `?sslmode=...` or other options to `POSTGRES_URL`, add the same options to `POSTGRES_MIGRATIONS_URL`.
