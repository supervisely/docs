# Supervisely Application Engine: how apps work under the hood

This doc explains high-level app lifecycle: how it is started and hosted, how it initialize UI, how it handle requists from user (e.g. button clicks) and so on.

## User starts application

App defines how it can be started: from context menu ([example](https://ecosystem.supervise.ly/apps/classes-stats-for-images)) or directly from applications page ([example](https://ecosystem.supervise.ly/apps/import-from-google-cloud-storage)).

Example: run from context  |  Example: run from `Team Apps` page
:-------------------------:|:-----------------------------------:
![](https://i.imgur.com/6jVrnAK.png)  |  ![](https://i.imgur.com/2HciaQv.png)






