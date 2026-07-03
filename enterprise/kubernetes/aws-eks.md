# AWS EKS

A from-scratch tutorial for building an **Amazon EKS** Kubernetes cluster that's ready to run Supervisely. It covers creating the cluster, storage, ingress, and (optionally) GPU nodes. When the cluster is ready, you deploy Supervisely on it with the Helm chart — either the [full platform](installation.md) or the [Kubernetes agent](kubernetes-agent.md).

If you already have a Kubernetes cluster, you can skip this page and go straight to those install guides.

The example uses this configuration:

- AWS region: `us-east-1`
- Cluster name: `supervisely-eks`
- Kubernetes version: `1.35`
- One managed node group with `t3.large`
- Public worker nodes
- NAT gateway disabled to reduce baseline cost

This is fine for testing and initial integration. For production, review node sizing, scaling, private networking, DNS, TLS, monitoring, and security.

**What you'll build:** install CLI tools → create an EKS cluster → add a storage class → install an ingress controller → (optionally) add GPU nodes → deploy Supervisely.

## Prerequisites

- An AWS account allowed to launch EC2 instances
- AWS permissions for EKS, IAM, CloudFormation, EC2, VPC, Auto Scaling, and public SSM parameters
- `aws`, `kubectl`, `eksctl`, and `helm` (v3) installed locally
- AWS credentials configured in your shell

## Step 1. Verify required tools

```bash
aws --version
kubectl version --client
eksctl version
helm version
```

If any command is missing, install the tool before proceeding.

## Step 2. Configure AWS access

Configure AWS credentials using either an AWS profile or environment variables.

Example using environment variables in bash:

```bash
export AWS_ACCESS_KEY_ID="<access-key-id>"
export AWS_SECRET_ACCESS_KEY="<secret-access-key>"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_PAGER=""
```

Verify access:

```bash
aws sts get-caller-identity
```

The command must return the active AWS identity.

Important: successful AWS authentication is not enough on its own. The AWS account must also be allowed to launch EC2 instances, otherwise EKS worker nodes will not start.

## Step 3. Create the EKS cluster

Save the following as `eksctl-supervisely-cluster.yaml`. It creates the cluster, a node group, and the **EBS CSI driver** add-on (needed for persistent storage in Step 5):

```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: supervisely-eks
  region: us-east-1
  version: "1.35"

autoModeConfig:
  enabled: false

accessConfig:
  authenticationMode: API_AND_CONFIG_MAP

iam:
  withOIDC: true

addons:
  - name: aws-ebs-csi-driver
    wellKnownPolicies:
      ebsCSIController: true

vpc:
  nat:
    gateway: Disable
  clusterEndpoints:
    publicAccess: true
    privateAccess: false

managedNodeGroups:
  - name: general
    instanceType: t3.large
    amiFamily: AmazonLinux2023
    desiredCapacity: 1
    minSize: 1
    maxSize: 2
    volumeType: gp3
    volumeSize: 30
    privateNetworking: false
    disableIMDSv1: true
```

{% hint style="info" %}
Want GPU tasks (training/inference)? Use a GPU instance type instead of `t3.large` **now**, before creating the cluster — see [GPU nodes](#gpu-nodes-optional) below.
{% endhint %}

Create the cluster:

```bash
eksctl create cluster -f ./eksctl-supervisely-cluster.yaml
```

Expected duration: 15 to 30 minutes.

This creates the EKS control plane, VPC networking, the IAM resources EKS needs, one managed node group, the EBS CSI driver add-on, and a local kubeconfig entry.

## Step 4. Verify cluster access

```bash
kubectl get nodes
kubectl get namespaces
```

Expected result:

- At least one node is in `Ready` state
- The API server responds to `kubectl`

Immediately after control plane creation, `kubectl get nodes` may temporarily return `No resources found` while the node group is still provisioning. Wait a few minutes and retry.

## Step 5. Set up a storage class

Supervisely stores data on persistent volumes, so the cluster needs a storage class that provisions them. Recent EKS versions (1.30+) don't mark **any** storage class as default and don't provision volumes until the **EBS CSI driver** is present — that's why Step 3 added the driver add-on. Here you create a `gp3` class, make it the default, and use `Retain` so volumes aren't deleted by accident.

Save this as `gp3-storageclass.yaml`:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: gp3
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
reclaimPolicy: Retain
```

Apply it:

```bash
kubectl apply -f gp3-storageclass.yaml
kubectl get storageclass
```

`gp3` should be marked `(default)`.

{% hint style="info" %}
If your cluster is an older version that still ships a `gp2` class marked default, unset it so there's only one default:

```bash
kubectl patch storageclass gp2 -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```
{% endhint %}

## Step 6. Install an ingress controller

An ingress controller exposes Supervisely (and browser-based apps) outside the cluster. The Supervisely chart defaults to **Traefik**, so this example installs Traefik, which provisions an AWS load balancer on EKS:

```bash
helm upgrade -i traefik traefik \
  --repo https://traefik.github.io/charts \
  --namespace traefik --create-namespace
```

Find the external address of the load balancer (you'll point your domain at it later):

```bash
kubectl -n traefik get service traefik
```

{% hint style="info" %}
An ingress controller is required for the full platform's web UI, and for opening GUI apps in the browser when using the agent. If you only run non-GUI agent workloads, you can skip this step.

This example uses **Traefik** because it's the chart default and a single install. The [Gateway API](https://gateway-api.sigs.k8s.io/) is the strategic successor to Ingress — the chart supports it via `controller: gateway` (it needs a few more steps: CRDs + an implementation + a `Gateway`). Traefik also speaks Gateway API, so starting here isn't a dead end. Avoid the upstream **ingress-nginx** controller for new clusters — the Kubernetes project is [retiring it](https://kubernetes.io/blog/2025/11/11/ingress-nginx-retirement/) (end of maintenance ~March 2026). See [Ingress](ingress.md) for all options.
{% endhint %}

## GPU nodes (optional)

Most people add a Kubernetes cluster so Supervisely can run **GPU** tasks. To do that, create the cluster in Step 3 with a GPU node group instead of `t3.large` — use this `managedNodeGroups` block (for example, a `g4dn.xlarge` instance):

```yaml
managedNodeGroups:
  - name: gpu
    amiFamily: Bottlerocket
    instanceType: g4dn.xlarge
    desiredCapacity: 1
    minSize: 1
    maxSize: 2
    volumeType: gp3
    volumeSize: 100
    privateNetworking: false
```

This uses the EKS **Bottlerocket accelerated AMI** (`amiFamily: Bottlerocket`), which ships the NVIDIA driver and device plugin **pre-installed** — so GPUs are exposed to Kubernetes as the `nvidia.com/gpu` resource with zero extra setup. (If you'd rather use the Amazon Linux 2023 GPU AMI, `eksctl` installs the [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin) for you automatically — same result.)

Once the GPU nodes are up, confirm they report GPUs:

```bash
kubectl get nodes -o custom-columns=NAME:.metadata.name,'GPU:.status.allocatable.nvidia\.com/gpu'
```

Each GPU node should show its GPU count. Then enable GPU pod presets in the Supervisely values file — see [Install full Supervisely](installation.md#gpu-workloads) or [Install the Kubernetes agent](kubernetes-agent.md).

If you don't need GPU, skip this section and keep the `t3.large` node group.

## Step 7. Deploy Supervisely

The cluster is ready. Now install Supervisely on it with the Helm chart. Pick the mode that fits your case:

* **Run the whole platform on this cluster** → [Install full Supervisely](installation.md). Use the ingress host from Step 6 and the `gp3` storage class from Step 5.
* **Connect this cluster as extra compute for an existing instance** → [Install the Kubernetes agent](kubernetes-agent.md).

Both start by fetching the chart with `supervisely k8s fetch-chart` and installing it with `supervisely k8s install`.

## Cleanup

Delete the cluster when it is no longer needed:

```bash
eksctl delete cluster --name supervisely-eks --region us-east-1
```

The example creates billable AWS resources. Remove the cluster after testing to avoid unnecessary charges. Note: with the `Retain` reclaim policy, EBS volumes created for Supervisely are **not** deleted automatically — remove any leftover volumes in the EC2 console if you no longer need the data.

## Troubleshooting

### `aws sts get-caller-identity` fails

The AWS credentials are missing or invalid. Reconfigure AWS access and retry.

### `RunInstances` returns `Blocked`

An AWS account-level restriction. The IAM user may be valid, but the account is not currently allowed to launch EC2 instances. Resolve it with the AWS account owner or AWS Support before retrying.

### Managed node group stays in `CREATING`

If the control plane is healthy but worker nodes do not appear, inspect the EKS node group status, Auto Scaling activities, and CloudFormation events for the node group stack. Common causes: EC2 quota limits, blocked EC2 launches, or account verification restrictions.

### `kubectl get nodes` returns `No resources found`

The control plane may be ready while the node group is still provisioning. Wait a few minutes and retry.

### `kubectl get nodes` fails after cluster creation

Refresh the kubeconfig entry and retry:

```bash
aws eks update-kubeconfig --region us-east-1 --name supervisely-eks
kubectl get nodes
```

### PersistentVolumeClaims stay `Pending`

Usually the storage class or the EBS CSI driver isn't ready. Confirm the `gp3` class exists and is default (Step 5), and that the driver is running: `kubectl -n kube-system get pods | grep ebs-csi`.

### The load balancer has no external address

On EKS the ingress controller's load balancer can take a couple of minutes to get an address. Re-run `kubectl -n traefik get service traefik`. If it never appears, check the controller pod logs and your subnet/role configuration.

### GPU nodes don't report GPUs

Confirm you used a GPU instance type and a GPU-capable AMI. With **Bottlerocket** the driver and plugin run on the node itself. With the **AL2023** GPU AMI, `eksctl` installs the device plugin — check its pods with `kubectl get pods -A | grep nvidia-device-plugin`.
