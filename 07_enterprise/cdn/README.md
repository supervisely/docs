Supervisely allows you to use CDN services to fetch images and videos in labeling tools to speedup data fetching from remote locations. This guide will help you to configure CND on external services.

## Cloudfront

a). Go to Services → Cloudfront → Distributions → Create distribution

b). Provide the following values:

— "Origin domain" type the domain address of your server that Amazon will use to get the files from. In most cases it will be your "SERVER_ADDRESS" value from the ".env" file;

— Protocol: Match viewer;

— HTTP port: use the value of "PROXY_PORT" from the ".env" file;

— Cache key and origin requests;

You can either select "Legacy cache settings" or setup policies to your liking.
CachePolicy: "CachingOptimized"
OriginPolicy: "AllViewer". Notice Supervisely might require cookies forwarding depending on the configuration.

c). Copy the "Distribution domain name"

```bash
cd $(sudo supervisely where)
```

Set "CDN_DOMAIN" in ".env" file to the value you've just copied:

```bash
CDN_DOMAIN=someawsdomain.cloudfront.net
```

Create or update `docker-compose.override.yml`:

```yaml
version: '2.4'
services:
  api:
    environment:
      CDN_DOMAIN: ${CDN_DOMAIN}
```

Deploy the changes:
```bash
sudo supervisely up -d api
```

d). Now you can go on and open any Labeling Tool, all the urls will be replaced with CDN domain. If nothing shows up, go back to the Distributions page on AWS and wait for status to change from "Deploying" to the current date.
