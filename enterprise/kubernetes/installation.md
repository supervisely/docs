# Install full Supervisely

This guide installs the **complete Supervisely platform** on your Kubernetes cluster using the Helm chart (`mode: full`). At the end you'll have a working Supervisely instance served through your ingress controller.

If instead you want to connect a cluster as extra compute for an existing instance, see [Install the Kubernetes agent](kubernetes-agent.md).

{% hint style="info" %}
New to the Helm chart? Read the [Overview](overview.md) first — it explains the two modes and how the chart is generated for your license.
{% endhint %}

## Before you start

Make sure you have:

* A Kubernetes cluster, version **1.21 or later**
* [`kubectl`](https://kubernetes.io/docs/tasks/tools/) and [`helm`](https://helm.sh/docs/intro/install/) (v3), both pointed at the cluster
* An **ingress controller** installed (`nginx`, `traefik`, `projectcontour`, `gateway`, or `istio`)
* A **storage class** for persistent data — a fast SSD/CSI class is recommended for production
* A domain name (for example `supervisely.mycompany.com`) that will point at your ingress
* Your Supervisely **license key**
* [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin) on GPU nodes, if you plan to run GPU workloads

## Step 1: Download the chart

Use the **Supervisely CLI** to fetch the chart for your license (the same `supervisely` command from the standard [installation](../installation/README.md); if you don't have it yet, see that page and set your license with `supervisely set-license <YOUR_LICENSE>`):

```bash
# latest version
supervisely k8s fetch-chart

# or a specific Supervisely version
supervisely k8s fetch-chart --version 6.12.3
```

This downloads and unpacks the chart into `supervisely-k8s/chart/` and prints the exact paths. The bundle contains `Chart.yaml`, a documented `values.yaml`, a `README.md`, and the `templates/` directory. The image registry is already configured for your version, so you don't need to set it up yourself.

## Step 2: Configure your values

Open the `values.yaml` that the CLI reported in Step 1 and set the handful of values that describe **your** environment. Everything else has sensible defaults.

```yaml
# Which mode to install. "full" installs the whole platform.
mode: full

# The domain where Supervisely will be reachable.
ingress:
  enabled: true
  controller: nginx          # nginx | traefik | projectcontour | gateway | istio
  host: supervisely.mycompany.com

options:
  # The full external URL of your instance. Used for links and integrations.
  serverAddress: https://supervisely.mycompany.com

# Your license (paste the key inline, or point to an existing secret).
license:
  init: "<YOUR_LICENSE>"
```

{% hint style="info" %}
**Passwords and tokens are generated for you.** You do **not** put database, queue or cache passwords in `values.yaml`. On install, the chart runs a small bootstrap job that generates every secret, stores it in a Kubernetes Secret, and reuses it on every upgrade so nothing gets rotated by accident. You only override a value if you have a specific reason to.
{% endhint %}

### Storage

By default the platform stores its data on persistent volumes provisioned by your default storage class. To pick a specific class, set it per service or globally in the values file, for example:

```yaml
services:
  defaults:
    volumes:
      storageClassName: fast-ssd
```

For production we recommend:

* A fast SSD / CSI storage class for the database and cache
* A `Retain` [reclaim policy](https://kubernetes.io/docs/tasks/administer-cluster/change-pv-reclaim-policy/) on that class to avoid accidental data loss
* Optionally, external managed services — see [Managed Postgres](../managed-postgres/README.md) and [Remote Storage (S3)](../s3/README.md). To use them, set the corresponding `options.*Host` / `options.*Password` / storage keys instead of running those components in-cluster.

### GPU workloads

If your cluster has GPU nodes with the NVIDIA device plugin installed, enable GPU pod presets so Supervisely can schedule GPU tasks. The generated `values.yaml` includes commented examples under `nodeManager.node.options.podsPresets` (a preset with `supportsGpu: true` and `runtimeClassName: nvidia`). Uncomment and adjust them to match your nodes.

### Ingress

`ingress.host` is the domain, and `ingress.controller` selects which controller the chart generates rules for. Each controller has a few extra options (ingress class, TLS secret, gateway reference). See the dedicated [Ingress](ingress.md) page for the exact keys and TLS setup.

## Step 3: Install the chart

Install the release with the CLI:

```bash
supervisely k8s install
```

`k8s install` fetches the chart if needed and runs `helm upgrade -i` for you, using the `values.yaml` from Step 1 and the release/namespace `supervisely` (both overridable — run `supervisely k8s --help`, or use the `SUPERVISELY_K8S_*` environment variables). The same command installs the first time and upgrades on later runs.

{% hint style="info" %}
Prefer to drive Helm yourself? Run it directly against the fetched chart:

```bash
helm upgrade -i supervisely supervisely-k8s/chart \
  --namespace supervisely \
  --create-namespace \
  -f supervisely-k8s/chart/values.yaml
```

To review the generated manifests before applying anything, swap `upgrade -i` for `template`.
{% endhint %}

## Step 4: Wait for the platform to come up

On the first install the chart runs a bootstrap job (to create secrets) and a database migration job before the main services start. Watch the rollout:

```bash
kubectl -n supervisely get pods
kubectl -n supervisely get jobs
```

Wait until the bootstrap and migration jobs show `Completed` and the service pods are `Running`.

## Step 5: Point your domain at the ingress

Create a DNS record for `ingress.host` pointing at your ingress controller's external address (load balancer hostname or IP):

```bash
kubectl -n supervisely get ingress
# or, to find the ingress controller's external address:
kubectl get svc -A | grep -i ingress
```

Once DNS resolves, open `https://supervisely.mycompany.com` in your browser.

## Step 6: First login

After the instance is up, follow the [Post-installation](../post-installation/README.md) guide to sign in, change the default password, and configure your instance.

## Updating and uninstalling

**Update** to a new version — fetch the newer chart and re-run install (your edited `values.yaml` is preserved):

```bash
supervisely k8s fetch-chart --version 6.13.0   # or omit --version for latest
supervisely k8s upgrade
```

See also [Upgrade](../update/upgrade.md).

**Uninstall** the release (this removes the workloads; persistent volumes may remain depending on your storage class reclaim policy):

```bash
supervisely k8s uninstall
```

## Troubleshooting

* **Pods stuck in `Pending`** — usually no node can satisfy the CPU/memory request or no volume can be provisioned. Check `kubectl -n supervisely describe pod <name>` and confirm your storage class works.
* **Bootstrap or migration job fails** — inspect its logs with `kubectl -n supervisely logs job/<job-name>`. Re-running `supervisely k8s upgrade` re-runs the jobs.
* **Site not reachable** — confirm the ingress controller is installed, `kubectl -n supervisely get ingress` shows an address, and DNS for `ingress.host` resolves to it. See [Ingress](ingress.md).
* **Images can't be pulled** — nodes need outbound access to the Supervisely registry. The chart configures the pull secret automatically; verify with `kubectl -n supervisely get secrets`.
