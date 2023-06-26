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

To be sure you can always go back to any previous versions we make automatic backups every time you run the `sudo supervisely upgrade` command.

We backup configuration and database files only:
- Configuration folder: directory where you have your `docker-compose.yml` and `.env` files. We usually choose `/opt/supervisely` or `/supervisely`, but if you have installed Supervisely yourself, this folder can be somewhere else.
- Database folder: sometimes your upgrade requires database migration so it's a good idea to backup the db before. Database files are stored in `${DATA_PATH}/db`. Default value is `/supervisely/data/db`.

### Step 3. Check your new version

Wait a couple minutes and open Supervisely. Everything should work fine and you can start using the new functionality.

## Troubleshooting

**My agent changed its status to WAITING**: There are two possible reasons - either agents were disconnected during the update (in this case just wait a couple more minutes), or you forgot to set `SERVER_ADDRESS` in `.env`.
  
**Nothing works now. How do I go back?**: In case of any problems with the new release it's easy to go back to a previous version. Just replace your new configuration files with the previous ones from the backup, do the same with the database folder and hit `docker-compose up -d` once again.
