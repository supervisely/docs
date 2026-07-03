# Kubernetes

Run Supervisely on Kubernetes with the official **Helm chart**. One chart covers two scenarios, chosen with a single `mode` value:

* **Full Supervisely** (`mode: full`) — the whole platform runs in your cluster.
* **Kubernetes agent** (`mode: kubernetes-agent`) — a lightweight agent that connects an existing Supervisely instance to your cluster to run apps and tasks.

Start here:

* [Overview](../../enterprise/kubernetes/overview.md) — the chart, the two modes, and how to get it
* [Install full Supervisely](../../enterprise/kubernetes/installation.md) — deploy the whole platform
* [Install the Kubernetes agent](../../enterprise/kubernetes/kubernetes-agent.md) — add a cluster as compute
* [Ingress](../../enterprise/kubernetes/ingress.md) — expose Supervisely through your ingress controller
* [AWS EKS](../../enterprise/kubernetes/aws-eks.md) — build a cluster from scratch on AWS, ready for Supervisely

{% hint style="info" %}
Prefer the simplest single-machine setup? The [Docker Compose installation](../../enterprise/installation/README.md) is the easier path when you don't need Kubernetes.
{% endhint %}
