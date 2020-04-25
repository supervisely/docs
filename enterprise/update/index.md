Follow this guide to upgrade your current Supervisely instance.

## Step-by-step manual

### Step 1. Bring your instance down

First, let's stop Supervisely. To do it, run `docker-compose stop` command in the folder with your `docker-compose.yml` file.

### Step 2. Backup your data and configuration

This step is optional, but highly recommended. To be sure you can always go back to the previous version, copy and save somewhere these two folders:

- Configuration folder: directory where you have your `docker-compose.yml` and `.env` files. We usually choose `/opt/supervisely` or `/supervisely`, but if you have installed Supervisely yourself, this folder can be somewhere else.
- Database folder: sometimes your upgrade requires database migration so it's a good idea to backup the db before. Database files are stored in `${DATA_PATH}/db`. Default value is `/supervisely/data/db`.

### Step 3. Replace your current configuration

Replace your current `docker-compose.yml` file with the one we have sent you.

Usually you don't have to replace your current `.env` file. Check that nothing has changed, but if something has, replace it, but do not forget to save the variables like `SERVER_ADDRESS` from the previous file.

### Step 4. Run update

Run `docker-compose up -d` in the folder with the `docker-compose.yml` file. This action will have two effects:

- Your current docker services like `api` or `web interface` will be started from the latest version
- (optional) New values for configuration may be applied
- (optional) `migrator` service may update your database structure to the latest version

### Step 5. Check your new version

Wait a couple minutes and open Supervisely. Everything should work fine and you can start using the new functionality.

## Example

Here is a typical script that does update:

```
# Switch to your Supervisely folder (docker-compose.yml directory)
cd /opt/supervisely

# Stop Supervisely
docker-compose stop

# Create backup dir
mkdir backup

# Copy database and current configuration to backup dir
cp /supervisely/data/db docker-compose.yml .env backup/

# Replace current configuration with updated 
cp ~/Downloads/supervisely-update/docker-compose.yml docker-compose.yml

# Restart docker services to run update
docker-compose up -d 
```

## Troubleshooting

**My agent changed its status to WAITING**: There are two possible reasons - either agents were disconnected during the update (in this case just wait a couple more minutes), or you forgot to set `SERVER_ADDRESS` in `.env`.
  
**Nothing works now. How do I go back?**: In case of any problems with the new release it's easy to go back to a previous version. Just replace your new configuration files with the previous ones from the backup, do the same with the database folder and hit `docker-compose up -d` once again.
