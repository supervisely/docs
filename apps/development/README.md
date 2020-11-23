# How to develop apps

icons - https://icons8.com/icons/color

how to create icons

при сохранении файла в `~/sessions/abc.png` файл сохраняется в `~/work/src/~/sessions/abc.png` 

app that download file (in venv) - директория сессии не существуюет my_app.data_dir не существует и не дает поотлаживать ее

how to create project and start debugging

api object from app service

This tutorial walks you through how to develop apps in Supervisely. It will show you how to add the necessary files and structure to create the app, how to debug an app, and how to integrate it to Supervisely platform.

What is application?

Supervisely application is the combination of two 
1. a
2. b
3. c
4. d

Types of applications (from simple to complex):
1. python script, for example app [Print Progress and Error](https://github.com/supervisely-ecosystem/debug-progress-error-app)
2. python script with app service, for example app [App Template (No GUI)](https://github.com/supervisely-ecosystem/app-template-headless)
4. app with modal window and/or GUI, for example app [Hello World App](https://github.com/supervisely-ecosystem/hello-world-app)


How to develop approaches
- python script, 
- app with venv
- app with custom dockerimage
- app with ...

The fastest way to start is to 
There are several approaches how you can start apps development (3 options): ...


Public vs Private apps: ...

Link to SDK quickstart, examples and documentaiton: ...

Directory structure
App config
Context menu
Github / releases
How to add private apps
Integrate app to labeling interface (images)


Apps - сделать два раздела в документации (user guide / developer guide)


## The Developer Guide
This guide is focuses on some basic information about Supervisely Apps and on step-by-step instructions for creating custom Supervisely Apps.

* Information
  * What Supervisely Apps are
  * Types of apps
  * How app works under the hood
  * Team files
  * [Application directory structure](./app-directory-structure.md)
  * Application config
  * Recommendations for README file (imgurl to decrease repository size, etc...)
* Prerequisites Installation
  * for MacOS
  * for Linux
* Quickstart
  * Fork one of the prepared templates
  * How to clone repository and start development
  * Cheese
* Tutorial
  * My first app
  * Debug your app
  * Add app to Supervisely
  * Test app right in Supervisely
  * Create releases
  
* Advanced usage
  * How to setup application output in workspace tasks
  * Multiuser Apps
  * UI widgets explained
  * Integration to Labeling Interfaces
  * NN integration (training, inference, serving, integration to Labeling interface)
