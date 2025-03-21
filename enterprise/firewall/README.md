Depending on the configuration settings Supervisely might send requests to Supervisely services to check for updates or fetch new Supervisely App versions or some other data.

{% hint style="warning" %}
Notice that while some of the domains are deprecated, they are still used in some cases. We recommend to allow all of them.
{% endhint %}

Here is the list of domains and their usage:
- `docker.enterprise.supervisely.com` - responsible for pulling docker images from Supervisely instance
- `hub.docker.com` or `registry.hub.docker.com` or `index.docker.io` - official Docker Hub Registry, responsible for pulling docker images for Supervisely Apps
- `config.enterprise.supervisely.com` - responsible for checking new Supervisely instance versions and instance upgrades
- `app.supervisely.com` - responsible for fetching new Supervisely App versions and its data
- `license.enterprise.supervisely.com` - responsible for syncing the license versions and license upgrades
- `github.com` - some of Supervisely Apps might fetch data from GitHub, like NN models, projects, etc.
