# Import using agent

We have several options for importing using an agent

## **Agent host directory**

Is a temporary folder that will host internal files, required for the agent to work. Mostly, it’s some kind of caches and so. This folder you can safely clean at any time, unless you have apps running or, for example, one of your training tasks has failed and you want to restore missing checkpoints.

![Agent app data](import-agent-1.png)

## **Folder to mount**

Is a permanent folder you can use to hold files and folders you wish to give applications access to.You can also provide a mounted folder with your images and use the context menu in the [team files](../../../team-files/README.md) to initiate the [import process](../Import-Team-Files.md).

## **Another way**

Besides we have an even better way to do this without the use of agents or the team files. You can actually add any folder on your server as a remote storage at the Instance Settings page using the “filesystem” provider, then use any [Supervisely App](https://ecosystem.supervisely.com/import), such as [Import images from cloud storage](https://ecosystem.supervisely.com/apps/import-images-from-cloud-storage) or [Import image projects in Supervisely format from cloud storage](https://ecosystem.supervisely.com/apps/import-images-in-sly-format-from-cloud-storage) and select your filesystem remote — this gives you are the flexibilities, plus, you don’t have to actually copy image files to the Supervisely storage — files will be added to your [datasets](../../../project/datasets/datasets.md) “by links”.
