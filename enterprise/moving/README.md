# Move Supervisely to another server

One of the most frequently asked questions is how to move an existing Supervisely instance from one machine/cloud to another machine/cloud? It's actually very easy.

## Step 1. Find where your Supervisely data and configuration is located

First, we need to transfer data and configuration files to the new machine. Run the following commands:

- `sudo supervisely where` — where your instance configuration is at
- `sudo supervisely where config` — where your cli configuration is at
- `sudo supervisely where data` — where your data is at

## Step 2. Transfer files to the new server

Create the same folders on the new server and copy contents. For example, your command to move data could look like this:

```bash
rsync -azP /opt/supervisely new_server:/opt/supervisely
# rsync -azP /opt/supervisely/config new_server:/opt/supervisely/config
# rsync -azP /opt/supervisely/data new_server:/opt/supervisely/data
```

## Step 3. Install Supervisely on a new machine

Install `supervisely-cli`, run `sudo sueprvisely install-all` and run `supervisely init`. Your license has already been copied on the previous step — just wait a bit for the installation to complete and you are good to go!
