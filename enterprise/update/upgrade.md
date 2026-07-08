Follow this guide to upgrade your current Supervisely instance.

## Using docker-compose.override to Pin Tool Versions

{% hint style="danger" %}
**Warning: Hardcoding tool versions is an emergency measure only.**

Pinning a specific version in `docker-compose.override.yml` bypasses the automatic update mechanism. This configuration is **not tracked** across containers — the platform assumes all services are running the latest released versions. A version mismatch between a pinned tool and the rest of the platform can cause unexpected errors, broken integrations, or silent data issues.

**Only pin a version when:**
- A regression in the latest release is actively blocking your workflow, **and**
- You are waiting for an official fix release and need a temporary workaround.

Remove the override as soon as the fix is available and you have upgraded to the patched version.
{% endhint %}

### What is docker-compose.override.yml?

Docker Compose automatically merges `docker-compose.override.yml` with the main `docker-compose.yml` at startup. You can use this file to override individual service settings — including the image tag — without modifying the base configuration managed by the Supervisely CLI.

Place the file in the same directory as `docker-compose.yml` (typically `/opt/supervisely` or `/supervisely`).

### Pinning a specific tool version

To lock a tool to a specific image version, create or edit `docker-compose.override.yml` and specify the exact image tag for the service you want to pin:

```yaml
version: "2.4"

services:
  annotation-tool-videos-v3:
    image: docker.enterprise.supervisely.com/supervisely-enterprise/core/annotation-tool-videos-v3:6.15.65
```

After saving the file, apply the change:

```bash
sudo supervisely up -d
```

The service will now run the pinned version and will **not** be updated automatically when you run `sudo supervisely upgrade`.

<!-- TODO: add screenshot of docker-compose.override.yml in the file manager or terminal -->
![docker-compose.override.yml example](placeholder-docker-compose-override.png)

### Removing the pin

Delete or comment out the override entry and redeploy:

```bash
sudo supervisely up -d
```

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

We back up configuration and database files only:
- Configuration folder: directory where you have your `docker-compose.yml` and `.env` files. We usually choose `/opt/supervisely` or `/supervisely`, but if you have installed Supervisely yourself, this folder can be somewhere else.
- Database folder: sometimes your upgrade requires database migration, so it's a good idea to back up the db before. Database files are stored in `${DATA_PATH}/db`. Default value is `/supervisely/data/db`.

### Step 3. Check your new version

Wait a couple of minutes and open Supervisely. Everything should work fine, and you can start using the new functionality.

## Troubleshooting

**My agent changed its status to WAITING**: There are two possible reasons - either agent were disconnected during the update (in this case just wait a couple more minutes), or you forgot to set `SERVER_ADDRESS` in `.env`.

**Nothing works now. How do I go back?**: In case of any problems with the new release it's easy to go back to a previous version. Just replace your new configuration files with the previous ones from the backup, do the same with the database folder and hit `supervisely up -d` once again.

**A tool or container is misbehaving after an upgrade**: If you experience errors related to a specific tool or container (crashes, API mismatches, unexpected behavior), check whether a `docker-compose.override.yml` file exists in your Supervisely directory and whether it pins any service to a specific version. A pinned version that is no longer compatible with the rest of the platform is a common cause of post-upgrade issues. Remove or update the pinned entry and redeploy with `sudo supervisely up -d`. See [Using docker-compose.override to Pin Tool Versions](#using-docker-composeoverride-to-pin-tool-versions).

**Upgrade fails with `service "postgres" is not running`**: If the upgrade command exits with a `curl: (22) The requested URL returned error: 500` and the message `service "postgres" is not running`, start the Postgres service first and then re-run the upgrade:
```
sudo supervisely start postgres
sudo supervisely upgrade --skip-backup
```

