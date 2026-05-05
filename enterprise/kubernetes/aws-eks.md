# AWS EKS

Everything you need to know about deploying Supervisely agent on an AWS EKS cluster.

## Deploy Supervisely Agent on AWS EKS

Supervisely can use Amazon Elastic Kubernetes Service (EKS) as a Kubernetes backend for running apps. This guide explains how to create a minimal EKS cluster, deploy the required Supervisely resources, and connect the cluster in the Supervisely UI.

The example in this document uses the following configuration:

- AWS region: `us-east-1`
- Cluster name: `supervisely-eks`
- Kubernetes version: `1.35`
- One managed node group with `t3.large`
- Public worker nodes
- NAT gateway disabled to reduce baseline cost

This configuration is suitable for testing and initial integration. For production environments, review networking, ingress, DNS, TLS, node sizing, scaling, monitoring, and security requirements.

## Table of Contents

- Prerequisites
- How it works
- Step 1. Verify required tools
- Step 2. Configure AWS access
- Step 3. Create the EKS cluster
- Step 4. Verify cluster access
- Step 5. Open Kubernetes connection in Supervisely
- Step 6. Deploy required resources
- Step 7. Fill the Kubernetes connection form
- Step 8. Connect the cluster in Supervisely
- Step 9. Verify the deployment
- Cleanup
- Troubleshooting

## Prerequisites

- AWS account that is allowed to launch EC2 instances
- Kubernetes 1.21 or above
- AWS permissions for EKS, IAM, CloudFormation, EC2, VPC, Auto Scaling, and public SSM parameters
- `aws`, `kubectl`, and `eksctl` installed locally
- Access to the Supervisely instance
- Bash or another POSIX-compatible shell environment with AWS credentials configured

### Network Requirements

- The Supervisely server address must be reachable from the Kubernetes cluster
- The Kubernetes API endpoint must be reachable from the Supervisely server
- If you plan to use GUI apps, the ingress address must resolve to the ingress controller or load balancer that serves app traffic

If you plan to run GPU workloads, use a GPU-capable node group instead of `t3.large` and enable GPU capability later in the Supervisely UI.

## How It Works

The EKS cluster provides the Kubernetes control plane and worker nodes.

The Kubernetes configuration generated in the Supervisely UI creates the resources required for Supervisely to work with the cluster:

- `sly-task-manager` service account and RBAC
- `sly-task-watcher` service account and RBAC
- `sly-task-manager-token` secret
- Image registry secret for Supervisely images

After these resources are created, read the service account token, Kubernetes API endpoint, and certificate authority data, and then enter those values in the Supervisely UI.

## Step 1. Verify Required Tools

Run the following commands to verify that the required tools are available:

```bash
aws --version
kubectl version --client
eksctl version
```

If any command is missing, install the tool before proceeding.

## Step 2. Configure AWS Access

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

## Step 3. Create the EKS Cluster

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
- Local kubeconfig entry for the cluster

The example cluster uses a public EKS API endpoint. This matches the requirement that the Kubernetes API endpoint must be reachable from the Supervisely server.

## Step 4. Verify Cluster Access

After cluster creation completes, run:

```bash
kubectl get nodes
kubectl get namespaces
```

Expected result:

- At least one node is in `Ready` state
- The API server responds to `kubectl`

Immediately after control plane creation, `kubectl get nodes` may temporarily return `No resources found` while the node group is still provisioning. Wait a few minutes and retry.

## Step 5. Open Kubernetes Connection in Supervisely

Open the Supervisely instance and go to:

`Cluster -> Connect -> Kubernetes`

This page contains:

- The Kubernetes connection form
- The generated Kubernetes configuration URL
- The generated deployment command
- The agent name field

The command has the following form:

```bash
curl -fsSLg "<generated-kubernetes-config-url>" | kubectl -n supervisely apply -f -
```

Do not submit the form yet. The required token and cluster values will be collected in the next steps.

## Step 6. Deploy Required Resources

Create the target namespace:

```bash
kubectl create namespace supervisely
```

Apply the generated manifest:

```bash
curl -fsSLg "<generated-kubernetes-config-url>" | kubectl -n supervisely apply -f -
```

Expected result:

- `sly-task-manager` service account is created
- `sly-task-watcher` service account is created
- RBAC roles and bindings are created
- `sly-task-manager-token` secret is created
- Image registry secret is created

You can verify the resources with:

```bash
kubectl -n supervisely get serviceaccounts
kubectl -n supervisely get secrets
kubectl -n supervisely get roles,rolebindings
```

## Step 7. Fill the Kubernetes Connection Form

The Kubernetes connection form in Supervisely contains fields that must be filled from different sources.

Use the following mapping:

| Field in Supervisely UI | Source | Notes |
| --- | --- | --- |
| Agent name | Supervisely UI | Set in the `Cluster -> Connect -> Kubernetes` dialog |
| Supervisely server address | Supervisely instance | Use the base URL of the current Supervisely instance. It must be reachable from the Kubernetes cluster |
| Service account token | Kubernetes secret | Read from `sly-task-manager-token` after applying the manifest |
| Kubernetes API endpoint | AWS EKS | Read with `aws eks describe-cluster`. It must be reachable from the Supervisely server |
| Certificate Authority | AWS EKS or Kubernetes secret | AWS output can be used directly |
| Namespace | Supervisely UI / Kubernetes | Use `supervisely` |
| Ingress address | Ingress controller / load balancer | Required if you want to use GUI apps in the browser |
| GPU capability of the cluster | Deployment choice | Enable only for GPU-capable node groups with NVIDIA device plugin installed |
| Use kubernetes services instead of ingress to access apps directly | Deployment choice | Use only when Supervisely itself runs inside the same cluster. Not recommended for production |
| Ingress manifest for Apps routing | Deployment choice | Use the default NGINX manifest or provide a custom manifest for your ingress controller |
| Ingress custom manifest | Custom ingress configuration | Fill only when `custom` is selected |

Depending on the Supervisely version, additional fields such as `Ingress path prefix` or `Registry secret` may also be available.

### Supervisely Server Address

Use the base URL of the Supervisely instance.

Example:

```text
https://your-instance-address.com
```

This address must be reachable from the Kubernetes cluster because apps and cluster-side components need to communicate with Supervisely.

### Service Account Token

Read the token from the Kubernetes secret and decode it:

```bash
kubectl -n supervisely get secret sly-task-manager-token -o jsonpath='{.data.token}' | base64 --decode
```

If the token is empty immediately after applying the manifest, wait a few seconds and retry.

### Kubernetes API Endpoint

Read the EKS cluster endpoint:

```bash
aws eks describe-cluster --region us-east-1 --name supervisely-eks --query "cluster.endpoint" --output text
```

Alternative:

```bash
kubectl cluster-info
```

This address must be reachable from the Supervisely server. If your EKS cluster uses a private-only API endpoint, the Supervisely server must have a network path to the cluster.

### Certificate Authority

Read the EKS cluster certificate authority data:

```bash
aws eks describe-cluster --region us-east-1 --name supervisely-eks --query "cluster.certificateAuthority.data" --output text
```

The value returned by AWS is base64-encoded and can be used directly in the Supervisely UI.

If needed, the same value can also be read from the Kubernetes secret:

```bash
kubectl -n supervisely get secret sly-task-manager-token -o jsonpath='{.data.ca\.crt}'
```

### Namespace

Use the following value:

```text
supervisely
```

### Ingress and GUI Apps

Ingress is required if you want to open Supervisely GUI apps in the browser.

Use the fields as follows:

- `Ingress address`: external hostname or IP address of your ingress controller or load balancer
- `Ingress manifest for Apps routing`: choose the manifest that matches your ingress controller
- `Ingress custom manifest`: provide your own manifest when `custom` is selected

If the cluster uses `ingress-nginx`, select the default NGINX manifest.

If the cluster uses another ingress controller, such as Traefik or a custom controller, use the matching manifest or provide your own.

If ingress is not configured, Supervisely can still run non-GUI workloads, but browser-accessible app UIs will not work correctly.

If your Supervisely version includes `Ingress path prefix`, use it to avoid conflicts with other services sharing the same ingress.

### GPU Capability of the Cluster

Enable this option only if the cluster has GPU-capable worker nodes and the NVIDIA device plugin is installed.

You can verify node labels with:

```bash
kubectl get nodes --show-labels
```

## Step 8. Connect the Cluster in Supervisely

Fill the Kubernetes connection form in Supervisely with the values collected in the previous step and save the connection.

Navigation path:

`Cluster -> Connect -> Kubernetes`

## Step 9. Verify the Deployment

Expected result:

- The cluster appears as connected in Supervisely
- Supervisely can create resources in the `supervisely` namespace

Recommended verification steps:

```bash
kubectl -n supervisely get serviceaccounts
kubectl -n supervisely get secrets
kubectl -n supervisely get roles,rolebindings
```

After the cluster is connected, launch a simple workload from Supervisely and verify that Kubernetes resources are created successfully.

If ingress is configured, also launch a GUI app and verify that it opens correctly in the browser.

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

This is an AWS account-level restriction. The IAM user may be valid, but the account is not currently allowed to launch EC2 instances.

Resolve the account restriction with the AWS account owner or AWS Support before retrying EKS creation.

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

### Kubernetes API endpoint is not reachable from the Supervisely server

The Supervisely server must be able to connect to the EKS API endpoint.

If the cluster uses a private endpoint, add network connectivity between the Supervisely server and the cluster VPC.

### Supervisely server address is not reachable from the cluster

Cluster-side components must be able to reach the Supervisely server URL.

Check DNS resolution, routing, proxies, firewalls, and security groups.

### GUI apps do not open

Check the ingress-related settings:

- `Ingress address`
- `Ingress manifest for Apps routing`
- `Ingress custom manifest`, if used

Also verify that the ingress controller is installed and that its external address is reachable.

### `kubectl -n supervisely apply -f -` fails because the namespace does not exist

Create the namespace first:

```bash
kubectl create namespace supervisely
```

### `sly-task-manager-token` exists but the token is empty

Wait a few seconds and retry the token command. Kubernetes can populate service account token secrets asynchronously.

### Images cannot be pulled in the cluster

The Supervisely manifest creates the image registry secret, but worker nodes still need outbound internet access to pull images.

The example configuration uses public worker nodes. If you move to private worker nodes, add the required egress design before deploying workloads.
