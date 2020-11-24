# Supervisely Application Engine: how apps work under the hood

This doc explains high-level app lifecycle: how it is started and hosted, how it initialize UI, how it handle requists from user (e.g. button clicks) and so on.

## 1. User starts application

App defines how it can be started: from context menu ([example](https://ecosystem.supervise.ly/apps/classes-stats-for-images)) or directly from applications page ([example](https://ecosystem.supervise.ly/apps/import-from-google-cloud-storage)).

Example: run from context  |  Example: run from `Team Apps` page
:-------------------------:|:-----------------------------------:
![](https://i.imgur.com/6jVrnAK.png)  |  ![](https://i.imgur.com/2HciaQv.png)

## 2. Task is created

Task is created and can be found in workspace tasks list ([example](https://github.com/supervisely-ecosystem/classes-stats-for-images)) or in application sessions (it depends on the app). `task_id` allows to directly communicate with the app via public API. Also you can view task logs and stop task.

Workspace tasks           |  Application sessions
:-------------------------:|:-----------------------------------:
![](https://i.imgur.com/C6zo9Q2.png)  |  ![](https://i.imgur.com/EVaMydM.png)









