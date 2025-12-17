# Multi-disk usage

In case you have multiple disks on your server, you can configure Supervisely to store data on multiple disks, including the Agent data. This will allow you to better utilize your server resources and increase the overall performance of your instance, sometimes it's necessary to store data on multiple disks due to the limited capacity of the OS drive.

### Docker data

1. To change the docker data folder location you first need to find its current location. To do that, run the following command:

```bash
sudo docker info | grep 'Docker Root Dir'
```

2. After locating the directory you need to stop the docker service:

```bash
sudo systemctl stop docker
```

3. (Optional) Then you need to move the data to the new location. This step is optional, because you can always easily download the images again, moving the docker folder if there are many docker images will take a lot of time:

```bash
sudo mkdir -p /new/path/docker
sudo rsync -avhPL /var/lib/docker/ /new/path/docker/
sudo mv /var/lib/docker /var/lib/del_me_docker

# run this command in background to clean up the old data
sudo rm -rf /var/lib/del_me_docker
```

4. Now you need to create a symlink to the new location:

```bash
sudo ln -s /new/path/docker /var/lib/docker
```

5. Finally, you need to start the docker service:

```bash
sudo systemctl start docker
```

Now all of your docker data will be stored in the new location `/new/path/docker`

### Supervisely server data

Please check [this article](../data-folder/) first for more details. You can link any folder in `DATA_PATH` to a different location.

Here's an example of how you could link storage to a different location:

```bash
sudo ln -s /new/path/for/storage /supervisely/data/storage
```

I'm assuming that you already have a folder `/new/path/for/storage` with the correct permissions and the value of `DATA_PATH` from `.env` is `/supervisely/data`

### Agent data

Agent uses 2 folders to store its data:

* user persistent data
* agent internal data, like tasks logs and caches

You can configure each folder using the advanced settings in the Agent Instructions UI. Start -> Team Cluster -> 3 dots -> Instructions.

Click on the `Advanced settings` button and you will see the following form: ![](../../.gitbook/assets/agent_offline_usage.png)

You should configure both "Agent host directory" and "Folder to mount" with the path to the new location. For example, you might want to have a dedicated folder for agents on another drive: `/mnt/storage/supervisely/agents`.

Then you can use it like this: Agent host directory: `/mnt/storage/supervisely/agents` Folder to mount: `/mnt/storage/supervisely/agents/agent-1`

After making the changes, click the blue button to copy the command and run it on the agent machine.
