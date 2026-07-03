# Overview

Supervisely ships an official **Helm chart** that installs and manages the platform on a Kubernetes cluster. Instead of applying dozens of raw YAML manifests by hand, you install one chart and control everything through a single `values.yaml` file.

{% hint style="info" %}
Kubernetes deployment is an advanced topic. You should be comfortable with `kubectl`, Helm, ingress controllers and persistent storage. If you just want the quickest way to run Supervisely on a single machine, use the [Docker Compose installation](../installation/README.md) instead.
{% endhint %}

## One chart, two modes

The same chart can be installed in one of two modes. You choose the mode with a single value (`mode`) in your `values.yaml`.

| Mode | Value | What it does | Use it when |
| --- | --- | --- | --- |
| **Full Supervisely** | `mode: full` | Installs the **entire platform** in your cluster — web UI, API, database, queue, cache, workers, storage and ingress. This is a complete, self-contained Supervisely instance. | You want to run Supervisely itself on Kubernetes. |
| **Kubernetes agent** | `mode: kubernetes-agent` | Installs a **lightweight agent** only. It turns the cluster into a compute backend that connects to an existing Supervisely instance and runs apps and tasks (including GPU workloads) on your cluster's nodes. | You already have a Supervisely instance and want to add Kubernetes as extra compute (for example, a GPU cluster). |

Both modes come from the **same chart** — you don't download anything different, you just set `mode` accordingly. See:

* [Install full Supervisely](installation.md) — `mode: full`
* [Install the Kubernetes agent](kubernetes-agent.md) — `mode: kubernetes-agent`

## How you get the chart

You download the chart with the **Supervisely CLI** — the same `supervisely` command used for the standard [installation](../installation/README.md). The CLI fetches a chart built for your license and version, so it always matches your entitlements and points at the correct image registry.

{% hint style="info" %}
Don't have the CLI yet? Supervisely provides a `supervisely` installation command together with your license — see [Installation](../installation/README.md). Once it's installed and your license is set (`supervisely set-license <YOUR_LICENSE>`), the commands below work.
{% endhint %}

Fetch the chart:

```bash
# latest version
supervisely k8s fetch-chart

# a specific Supervisely version
supervisely k8s fetch-chart --version 6.12.3
```

This downloads and unpacks the chart into `supervisely-k8s/chart/` (change the location with `--output`). The bundle is a ready-to-use Helm chart: `Chart.yaml`, a documented `values.yaml`, a `README.md`, and the `templates/`. The CLI prints the exact paths when it finishes.

Later, `supervisely k8s install` / `upgrade` / `uninstall` drive the deploy for you (they wrap `helm upgrade -i` / `helm uninstall`). You can always run `helm` directly against the fetched chart if you prefer.

## Prerequisites

* A Kubernetes cluster, version **1.21 or later**
* [`kubectl`](https://kubernetes.io/docs/tasks/tools/) and [`helm`](https://helm.sh/docs/intro/install/) (v3) installed and pointed at your cluster
* An **ingress controller** already installed in the cluster. The chart supports `traefik` (default), `nginx`, `projectcontour`, the Kubernetes `gateway` API, and `istio`. See [Ingress](ingress.md).
* A **storage class** for persistent data (a fast SSD/CSI storage class is recommended for production)
* [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin) on GPU nodes if you plan to run GPU workloads

## No cluster yet?

If you don't have a Kubernetes cluster, there's a from-scratch tutorial for building one on a managed cloud service (cluster, storage, ingress, optional GPU), ready to deploy either mode onto:

* [Build a cluster on AWS EKS](aws-eks.md)
