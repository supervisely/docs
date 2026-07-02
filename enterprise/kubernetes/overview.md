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

The chart is generated specifically for your license and Supervisely version. You download it from the Supervisely enterprise config service:

**[config.enterprise.supervisely.com](https://config.enterprise.supervisely.com)**

This is the same service that serves the Docker Compose configuration and the `supervisely` CLI. When you request the chart, you get a ready-to-use bundle: `Chart.yaml`, a documented `values.yaml`, and all templates — already pointed at the correct image registry for your version.

You can download it with a single command (replace `<YOUR_LICENSE>` with your license key):

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"license": "<YOUR_LICENSE>"}' \
  -fL -o supervisely-helm-chart.tar \
  "https://config.enterprise.supervisely.com/init?configType=helm"

mkdir supervisely-chart && tar -xf supervisely-helm-chart.tar -C supervisely-chart
```

{% hint style="info" %}
If you don't have a license key or you'd like the Supervisely team to pre-fill a `values.yaml` for your environment, just reach out to Supervisely support and we'll generate the chart for you.
{% endhint %}

## Prerequisites

* A Kubernetes cluster, version **1.21 or later**
* [`kubectl`](https://kubernetes.io/docs/tasks/tools/) and [`helm`](https://helm.sh/docs/intro/install/) (v3) installed and pointed at your cluster
* An **ingress controller** already installed in the cluster. The chart supports `nginx`, `traefik` (default), `projectcontour`, the Kubernetes `gateway` API, and `istio`. See [Ingress](ingress.md).
* A **storage class** for persistent data (a fast SSD/CSI storage class is recommended for production)
* [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin) on GPU nodes if you plan to run GPU workloads

## An alternative: connect a cluster from the UI

If you only need Kubernetes as extra compute and you don't want to install a Helm chart, you can instead connect an existing cluster directly from the Supervisely web interface. You apply a small manifest that creates a service account, then paste the cluster details into Supervisely. This works even with the Supervisely SaaS/cloud instance.

* [Connect a cluster from the UI](agent.md)
* [Step-by-step example on AWS EKS](aws-eks.md)

The Helm **Kubernetes agent** mode and the UI **Connect cluster** flow achieve the same goal (running apps on your cluster) — pick whichever fits your setup.
