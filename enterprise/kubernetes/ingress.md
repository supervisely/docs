# Ingress

Ingress is how traffic from the outside world reaches Supervisely running inside your cluster. The Helm chart generates the right ingress resources for you — you just tell it **which controller** you use and **which domain** to serve.

{% hint style="info" %}
The chart does **not** install an ingress controller. You need one already running in the cluster (see the links below). The chart only creates the routing rules for it.
{% endhint %}

## The two values you almost always set

```yaml
ingress:
  enabled: true              # set false only if you handle routing yourself
  controller: nginx          # which controller to generate rules for
  host: supervisely.mycompany.com   # your domain
```

* **`ingress.controller`** — which ingress controller you have. This decides which kind of resources the chart generates.
* **`ingress.host`** — the domain name where Supervisely is reachable. This becomes the host in the generated ingress rule. Create a DNS record for it pointing at your ingress controller's external address.

## Supported controllers

| `ingress.controller` | Controller | Install docs |
| --- | --- | --- |
| `traefik` (default) | Traefik | [install](https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart) |
| `nginx` | NGINX Ingress | [install](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start) |
| `projectcontour` | Contour | [install](https://projectcontour.io/getting-started/#option-2-helm) |
| `gateway` | Kubernetes Gateway API | [docs](https://gateway-api.sigs.k8s.io/) |
| `istio` | Istio | [install](https://istio.io/latest/docs/setup/getting-started/) |

Sensible defaults for each controller are applied automatically, so most installs only need `controller` and `host`.

## Per-controller options

Extra options go under `ingress.options`. You only need these if the defaults don't match your setup.

### NGINX

```yaml
ingress:
  controller: nginx
  host: supervisely.mycompany.com
  options:
    ingressClassName: nginx     # default: nginx
    tlsSecretName: ""           # set to enable TLS (see below)
```

### Traefik

```yaml
ingress:
  controller: traefik
  host: supervisely.mycompany.com
  options:
    entrypoint: websecure       # default: websecure
    ingressClassName: traefik
    tlsSecretName: ""           # set to enable TLS
```

### Istio

Istio routes through an existing Gateway, so you reference it instead of setting a TLS secret:

```yaml
ingress:
  controller: istio
  host: supervisely.mycompany.com
  options:
    gateway: istio-ingress/private-gateway   # <namespace>/<gateway-name>
```

### Gateway API

```yaml
ingress:
  controller: gateway
  host: supervisely.mycompany.com
  options:
    gateway: my-gateway
    gatewayNamespace: default
    sectionName: https
    port: 443
```

### Contour

```yaml
ingress:
  controller: projectcontour
  host: supervisely.mycompany.com
  options:
    tls: {}     # configure TLS on the HTTPProxy
```

## Enabling HTTPS (TLS)

For `nginx` and `traefik`, create a Kubernetes TLS secret with your certificate and reference it:

```bash
kubectl -n supervisely create secret tls supervisely-tls \
  --cert=fullchain.pem --key=privkey.pem
```

```yaml
ingress:
  options:
    tlsSecretName: supervisely-tls
```

For `istio`, `gateway` and `projectcontour`, TLS is configured on the Gateway / HTTPProxy that you reference, not on the chart — follow your controller's documentation.

{% hint style="info" %}
Supervisely also has a built-in HTTPS option that terminates TLS inside the platform. For Kubernetes deployments, terminating TLS at the ingress controller (as above) is usually simpler. See [HTTPS](../https/index.md) for the built-in option.
{% endhint %}

## Custom annotations

You can add your own annotations to the generated ingress resources — for example, to work with external-dns or cert-manager:

```yaml
ingress:
  annotations:
    external-dns.alpha.kubernetes.io/target: "203.0.113.10"
    cert-manager.io/cluster-issuer: letsencrypt-prod
```

## Checking it works

```bash
kubectl -n supervisely get ingress
```

Confirm the resource shows your `host` and an external address, then verify DNS for that host resolves to your ingress controller. If the site doesn't load, double-check that the ingress controller is installed and its external IP/hostname is reachable.
