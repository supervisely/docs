# Supervisely Application Engine: how apps work under the hood

This doc explains high-level app lifecycle: how it is started and hosted, how it initialize UI, how it handle requists from user (e.g. button clicks) and so on.

## 1. User starts application

App defines how it can be started: from context menu ([example](https://ecosystem.supervise.ly/apps/classes-stats-for-images)) or directly from applications page ([example](https://ecosystem.supervise.ly/apps/import-from-google-cloud-storage)).

Example: run from context  |  Example: run from `Team Apps` page
:-------------------------:|:-----------------------------------:
![](https://i.imgur.com/6jVrnAK.png)  |  ![](https://i.imgur.com/2HciaQv.png)

## 2. Modal Window before start (Optional)
Some apps may have a modal window that allows to configure some input parameters before starting an app. These parameters will be passed to app using environment variables. [Example](https://ecosystem.supervise.ly/apps/classes-stats-for-images)

<img src="https://i.imgur.com/lI6jenf.png" width="400"/>

## 3. Task is created

Task is created and can be found in workspace tasks list ([example](https://github.com/supervisely-ecosystem/classes-stats-for-images)) or in [application sessions](https://ecosystem.supervise.ly/apps/labeling-events-stats) (it depends on the app). `task_id` allows to directly communicate with the app via public API. Also you can view task logs and stop task.

Workspace tasks           |  Application sessions
:-------------------------:|:-----------------------------------:
![](https://i.imgur.com/C6zo9Q2.png)  |  ![](https://i.imgur.com/EVaMydM.png)


## 4. Agent starts app

- receives a message from Supervisely Server  
- pulls docker image
- download app sources from github for a selected version or from `master` branch (vertioned releases are cached on agent to speed up running process). `master` branch is not cached and is always downloaded from github
- (optional) installs packages from `requirements.txt` (using pip cache for speed up)
- runs docker container: sources and task directory are mounted to docker container. Running command is an entrypoint script that is defined in application config. All input parameters and context are passes in form of environment variables to container
- connects to containers logs and streams them to Supervisely Server
- 

## 5. Application starting

- app reads input parameters from environment veriables
- (optional) app initializes UI (html template, data dictionary and state dictionary)
- app starts application service in backgorund and connects to Supervisely Server to receive events: button clicks, stop event, ...
- Note: App Engine is a part of Supervisely python SDK, it executes received events asynchronous





## 5. Application runnning

Let's consider some basic example: `Hello World App`. This app has UI: user clicks on the button, app generates random string and shows it in UI. 
Here is demo how it works:

![](../images/hello-world.gif)



- app uses public API to modify the state/data of UI widgets
- 

http://www.giphy.com/gifs/pEjEyyHEi5x5eyCLuJ


![](https://i.imgur.com/bHP9faS.mp4)



![](https://i.imgur.com/5IrRv6i.png)
