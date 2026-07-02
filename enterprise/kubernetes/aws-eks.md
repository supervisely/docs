# AWS EKS

A step-by-step example of deploying the Supervisely **Kubernetes agent** on an Amazon EKS cluster using the Helm chart. At the end, your EKS cluster is connected to an existing Supervisely instance as a compute backend that runs apps and tasks.

This page focuses on the EKS-specific parts (creating the cluster, AWS access, networking). For the agent chart itself and all its values, see [Install the Kubernetes agent](kubernetes-agent.md).

The example uses this configuration:

- AWS region: `us-east-1`
- Cluster name: `supervisely-eks`
- Kubernetes version: `1.35`
- One managed node group with `t3.large`
- Public worker nodes
- NAT gateway disabled to reduce baseline cost

This is suitable for testing and initial integration. For production, review networking, ingress, DNS, TLS, node sizing, scaling, monitoring, and security requirements. To run GPU workloads, use a GPU-capable node group instead of `t3.large` and install the [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin).

## Prerequisites

- AWS account that is allowed to launch EC2 instances
- Kubernetes 1.21 or above
- AWS permissions for EKS, IAM, CloudFormation, EC2, VPC, Auto Scaling, and public SSM parameters
- `aws`, `kubectl`, `eksctl`, and `helm` (v3) installed locally
- An existing, reachable Supervisely instance and your license key
- A Bash or another POSIX-compatible shell with AWS credentials configured

### Network requirements

- The Supervisely instance address must be reachable **from** the EKS cluster (the agent connects to it and streams task logs to it).
- If you want to open GUI apps in the browser, the ingress address must resolve to the ingress controller or load balancer that serves app traffic.

## How it works

The EKS cluster provides the Kubernetes control plane and worker nodes. The Supervisely **Kubernetes agent** Helm chart (`mode: kubernetes-agent`) installs only the pieces needed to run tasks on the cluster:

- A task namespace (with a network policy) where app/task pods run
- RBAC and a service account so Supervisely can manage task pods
- A one-time registration job that adds the cluster to your Supervisely instance as a compute node
- A logs agent that streams task logs back to the instance

Once the chart is installed, the cluster shows up in your Supervisely instance as an available compute backend.

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

Save the following configuration as `eksctl-supervisely-cluster.yaml`:

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

Create the cluster:

```bash
eksctl create cluster -f ./eksctl-supervisely-cluster.yaml
```

Expected duration: 15 to 30 minutes.

This command creates:

- The EKS control plane
- VPC networking for the cluster
- IAM resources required by EKS
- One managed node group
- A local kubeconfig entry for the cluster

## Step 4. Verify cluster access

After cluster creation completes, run:

```bash
kubectl get nodes
kubectl get namespaces
```

Expected result:

- At least one node is in `Ready` state
- The API server responds to `kubectl`

Immediately after control plane creation, `kubectl get nodes` may temporarily return `No resources found` while the node group is still provisioning. Wait a few minutes and retry.

## Step 5. Install an ingress controller (optional)

If you want to run GUI apps in the browser, install an ingress controller in the cluster (for example, [ingress-nginx](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start)). On EKS this typically provisions an AWS load balancer. Note its external address — you'll point app traffic at it. See [Ingress](ingress.md).

If you only run non-GUI workloads, you can skip this step.

## Step 6. Install the Kubernetes agent

Download the Helm chart for your license and unpack it (replace `<YOUR_LICENSE>`):

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"license": "<YOUR_LICENSE>"}' \
  -fL -o supervisely-helm-chart.tar \
  "https://config.enterprise.supervisely.com/init?configType=helm"

mkdir supervisely-agent && tar -xf supervisely-helm-chart.tar -C supervisely-agent
cd supervisely-agent
```

Create a `values.yaml` that selects agent mode and points at your existing Supervisely instance:

```yaml
mode: kubernetes-agent

options:
  serverAddress: https://your-instance-address.com

services:
  logsAggregator:
    taskExecution:
      apiUrl: https://your-instance-address.com
      token:
        value: "<TASK_EXECUTION_TOKEN>"
```

{% hint style="info" %}
The exact agent connection values depend on your instance. The simplest path is to have Supervisely generate a ready-to-use agent `values.yaml` for you. See [Install the Kubernetes agent](kubernetes-agent.md) for the full list of values, plus storage and GPU settings.
{% endhint %}

Install the chart:

```bash
helm upgrade -i supervisely-agent . \
  --namespace supervisely \
  --create-namespace \
  -f values.yaml
```

## Step 7. Verify the deployment

Check that the agent pods and the registration job are healthy:

```bash
kubectl -n supervisely get pods
kubectl -n supervisely get jobs
```

The registration job should show `Completed`, and the logs agent pod should be `Running`.

Then open your Supervisely instance: the EKS cluster should now appear as an available compute backend. Launch a simple workload and confirm that Kubernetes resources are created in the `supervisely` namespace:

```bash
kubectl -n supervisely get pods
```

If ingress is configured, launch a GUI app and confirm it opens in the browser.

## Cleanup

Delete the cluster when it is no longer needed:

```bash
eksctl delete cluster --name supervisely-eks --region us-east-1
```

The example configuration creates billable AWS resources. Remove the cluster after testing to avoid unnecessary charges.

## Troubleshooting

### `aws sts get-caller-identity` fails

The AWS credentials are missing or invalid. Reconfigure AWS access and retry.

### `RunInstances` returns `Blocked`

This is an AWS account-level restriction. The IAM user may be valid, but the account is not currently allowed to launch EC2 instances. Resolve it with the AWS account owner or AWS Support before retrying EKS creation.

### Managed node group stays in `CREATING`

If the control plane is healthy but worker nodes do not appear, inspect:

- EKS node group status
- Auto Scaling activities
- CloudFormation events for the node group stack

Common causes include EC2 quota limits, blocked EC2 instance launches, or account verification restrictions.

### `kubectl get nodes` returns `No resources found`

The control plane may be ready while the node group is still provisioning. Wait a few minutes and run the command again.

### `kubectl get nodes` fails after cluster creation

Refresh the kubeconfig entry and retry:

```bash
aws eks update-kubeconfig --region us-east-1 --name supervisely-eks
kubectl get nodes
```

### The Supervisely instance is not reachable from the cluster

The agent must be able to reach your Supervisely instance URL. Check DNS resolution, routing, proxies, firewalls, and security groups. If the instance uses a private-only address, add a network path from the EKS VPC to it.

### The registration job fails

Inspect its logs:

```bash
kubectl -n supervisely get jobs
kubectl -n supervisely logs job/<registration-job-name>
```

Most failures come from an unreachable instance address or incorrect agent connection values. Fix the values and re-run `helm upgrade -i`.

### Images cannot be pulled in the cluster

Worker nodes need outbound internet access to pull Supervisely images. The chart configures the pull secret, but the example uses public worker nodes for egress. If you move to private worker nodes, add the required egress (NAT/endpoints) before deploying workloads.

### GUI apps do not open

Confirm an ingress controller is installed, its external address is reachable, and DNS resolves to it. See [Ingress](ingress.md).
