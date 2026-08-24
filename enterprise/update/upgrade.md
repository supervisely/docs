Follow this guide to upgrade your current Supervisely instance.

## Step-by-step manual

### Step 1. Update Supervisely CLI
Make sure you're using the latest Supervisely CLI:
```
sudo supervisely self-update
```

### Step 2. Backup + Update + Deploy
One single command to handle them all:
```
sudo supervisely upgrade
```

To be sure you can always go back to any previous versions we make automatic backups every time you run the `sudo supervisely upgrade` command. See [Going back to a previous version](#going-back-to-a-previous-version) below.

We back up configuration and database files only:
- Configuration folder: directory where you have your `docker-compose.yml` and `.env` files. We usually choose `/opt/supervisely` or `/supervisely`, but if you have installed Supervisely yourself, this folder can be somewhere else.
- Database folder: sometimes your upgrade requires database migration, so it's a good idea to back up the db before. Database files are stored in `${DATA_PATH}/db`. Default value is `/supervisely/data/db`.

### Step 3. Check your new version

Wait a couple of minutes and open Supervisely. Everything should work fine, and you can start using the new functionality.

## Going back to a previous version

If the new release doesn't work for you, one command puts the instance back the way it was before the upgrade — the database and the configuration together:

```
sudo supervisely rollback
```

To pick an older backup instead of the most recent one, run `restore` and choose from the list:

```
sudo supervisely restore
```

```
6.17.21  ·  24 Aug 2026, 11:22  ·  12G
6.17.20  ·  22 Aug 2026, 09:11  ·  12G
6.17.19  ·  15 Aug 2026, 08:03  ·  11G
```

You can also name one directly, which is what you'd do from a script:

```
sudo supervisely restore --version 6.17.20
sudo supervisely restore --date 2026-08-22
sudo supervisely restore --list            # just show what you have
```

Supervisely keeps running while the images and the database are copied, and goes offline for about a minute at the end while the containers are recreated. **Anything created after the backup was taken is lost.**

### Undoing a rollback

Whatever a restore replaces is kept as a **restore point**, so running `sudo supervisely rollback` again straight afterwards takes you back to where you started. A restore point keeps the database directory itself rather than another copy of it, so returning to one takes the same minute no matter how large your database is.

## Removing old backups

Backups are never deleted on their own, and each one is roughly the size of your database. To clear out the oldest:

```
sudo supervisely backup prune
```

It keeps the three newest, lists exactly what it would delete and how much space that frees, and asks before deleting anything. Use `--keep <N>` to keep a different number, and `--older-than <days>` to delete only backups past a certain age.

## Troubleshooting

**My agent changed its status to WAITING**: There are two possible reasons - either agent were disconnected during the update (in this case just wait a couple more minutes), or you forgot to set `SERVER_ADDRESS` in `.env`.

**Nothing works now. How do I go back?**: Run `sudo supervisely rollback`. See [Going back to a previous version](#going-back-to-a-previous-version).

**Upgrade fails with `service "postgres" is not running`**: If the upgrade command exits with a `curl: (22) The requested URL returned error: 500` and the message `service "postgres" is not running`, start the Postgres service first and then re-run the upgrade:
```
sudo supervisely start postgres
sudo supervisely upgrade --skip-backup
```

