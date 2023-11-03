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
In case you don't have POSTGRES_SSL in your configuration, you will have to [upgrade](/enterprise-edition/get-supervisely/upgrade) your Supervisely installation to the latest version (at least 6.8.47).
{% endhint %}

You will have to change the values of the variables to match your database configuration. For example, if you are using Amazon RDS, you will have to change the values to something like this:

```bash
POSTGRES_DATABASE=supervisely
POSTGRES_HOST=supervisely.123456789012.us-east-1.rds.amazonaws.com
POSTGRES_USER=supervisely
POSTGRES_SSL=true
```

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
PGPASSWORD=your_rds_password psql -h your_rds_endpoint -U your_rds_username -d your_rds_db_name -f /path/to/host/supervisely_postgres_dump.sql
```
