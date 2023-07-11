Depending on the configuration settings Supervisely might send requests to Supervisely services to check for updates or fetch new Supervisely App versions or some other data.

Here is the list of domains and their usage:
- docker.enterprise.supervise.ly - used to pull docker images for Supervisely instance
- hub.docker.com or registry.hub.docker.com or index.docker.io - official Docker Hub Registry, used to pull docker images for Supervisely Apps
- config.enterprise.supervise.ly - used to check for new Supervisely instance versions and instance upgrades
- app.supervisely.com - used to fetch new Supervisely App versions and its data
- cloud.enterprise.supervise.ly - deprecated functionality, used to fetch legacy data for initialization
- git.ecosystem.supervise.ly - deprecated functionality, used to fetch Supervisely App versions and its data