This document describes how to configure Supervisely to use HTTP proxy. This is useful if your network requires all outgoing traffic to go through a proxy server.

### Configuring Host and Docker to use HTTP proxy

Since there is no standard way to configure an HTTP proxy for every application, we need to make sure that both the host and Docker are configured to use the proxy.

The host configuration is usually configured via environment variables via `/etc/environment` file.
Here is an example:

```bash
http_proxy="http://proxy_server_ip:proxy_port"
https_proxy="http://proxy_server_ip:proxy_port"
no_proxy="localhost,other_private_addresses"
```

To configure Docker client to use HTTP proxy, you need to set the variables for dockerd service.

Create a folder in the systemd folder:

```bash
sudo mkdir /etc/systemd/system/docker.service.d
```

Create a file `/etc/systemd/system/docker.service.d/http-proxy.conf` with the following content:

```bash
[Service]
Environment="HTTP_PROXY=http://proxy_server_ip:proxy_port"
Environment="HTTPS_PROXY=http://proxy_server_ip:proxy_port"
Environment="NO_PROXY=localhost,other_private_addresses"
```

Apply configuration and restart docker service:

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

{% hint style="info" %}
if the method above doesn't work, or you don't use systemd, please check out the official [documentation](https://docs.docker.com/network/proxy/)
{% endhint %}

### HTTP proxy

To configure Supervisely to use HTTP proxy, you need to set the following variables in the `.env` file in the `sudo supervisely where` folder:

```bash
SLY_HTTPS_PROXY=
SLY_HTTP_PROXY=
SLY_NO_PROXY=
```

{% hint style="info" %}
By default Supervisely Agents use the same proxy settings as the Supervisely instance. If you want to use different proxy settings you can configure them in the advanced settings of the Instructions dialog window on the Team Cluster page. Don't forget to redeploy the Agent after changing the settings.
{% endhint %}

### HTTPS proxy with a custom CA certificate

In case you're using an HTTPS proxy with a custom CA certificate, you need to add the CA certificate to the trusted store on the server.

Copy the CA certificate to the following folder:

```bash
/usr/local/share/ca-certificates/
```

After that run the following command:

```bash
sudo update-ca-certificates
```

That will concatenate all certificates to `/etc/ssl/certs/ca-certificates.crt` which we can then use for Supervisely.

Now we need to let Supervisely know where to find the CA certificate.

1. Cd to the Supervisely workdir:

```bash
cd `sudo supervisely where`
```

2. Create a `docker-compose.override.yml` if it doesn't exist or merge it with the existing one:

```yaml
services:
  api:
    environment:
      NODE_EXTRA_CA_CERTS: '/usr/local/share/ca-certificates/'
    volumes:
      - /usr/local/share/ca-certificates/:/usr/local/share/ca-certificates/:ro
  api-public:
    environment:
      NODE_EXTRA_CA_CERTS: '/usr/local/share/ca-certificates/'
    volumes:
      - /usr/local/share/ca-certificates/:/usr/local/share/ca-certificates/:ro
  http-storage:
    environment:
      NODE_EXTRA_CA_CERTS: '/usr/local/share/ca-certificates/'
    volumes:
      - /usr/local/share/ca-certificates/:/usr/local/share/ca-certificates/:ro
  migrator:
    environment:
      NODE_EXTRA_CA_CERTS: '/usr/local/share/ca-certificates/'
    volumes:
      - /usr/local/share/ca-certificates/:/usr/local/share/ca-certificates/:ro
  worker-general:
    environment:
      NODE_EXTRA_CA_CERTS: '/usr/local/share/ca-certificates/'
    volumes:
      - /usr/local/share/ca-certificates/:/usr/local/share/ca-certificates/:ro
```

3. Deploy the changes:

```bash
sudo supervisely up -d
```

{% hint style="info" %}
Supervisely Agent can be configured to use the CA certificate by editing "Agent host CA cert path" in the advanced settings. You can find advanced settings in the Instructions dialog window on the Team Cluster page. Don't forget to redeploy the Agent after changing the settings.
{% endhint %}
