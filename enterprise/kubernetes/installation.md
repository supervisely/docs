Follow these steps to deploy Supervisely in Kubernetes cluster.

{% hint style="warning" %}
**BETA** keep in mind that this is a beta version and some features may not work as expected.
The configuration provided by Supervisely is a proof of concept (POC) and not suitable for production use out of the box.
{% endhint %}

{% hint style="info" %}
For a production deployment, you should have strong working knowledge of Kubernetes, you can follow the recommendations in this guide to customize the configuration for your needs.
{% endhint %}

## Pre-requirements

- Kubernetes cluster version `1.19` and later
- [NVIDIA Device plugin](https://github.com/NVIDIA/k8s-device-plugin) (if you plan to use GPU features)
- [NGINX ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/) (let us know if you want to use another ingress controller)

## Installation

## Step 1: Request a Kubernetes configuration
To deploy Supervisely in Kubernetes, you will need a POC configuration file that describes all the Supervisely services required for Kubernetes deployment.

## Step 2: Deploy Supervisely in Kubernetes
After receiving the configuration, you will have to make some adjustments to it. The configuration is provided as a YAML file that you can apply to your cluster using the `kubectl` command.

Here is the list of changes that we recommend for production use:

1) Deploy a managed PostgreSQL server and change the `POSTGRES_URL` env in the YAML configuration file.
It's highly recommended that you deploy a managed server to make sure your data is safe, scalable and available 24/7.
The deployed PostgreSQL server should be accessible from the Kubernetes cluster.
2) Deploy a managed storage solution and adjust `STORAGE_*` envs according to the documentation of your storage solution [here](https://docs.supervisely.com/enterprise-edition/advanced-tuning/s3).
This is highly recommended for production use.
3) Change the `SERVER_ADDRESS` and `DOMAIN` envs in the YAML configuration file to the URL of your Supervisely server, it can be private or public address.
It's mostly used for SSO (in which case it has to match redirect-uri and callback URL) and internal communication between the server and Supervisely agents (if you have dedicated server that are not in Kubernetes cluster, but you want to connect them to the Supervisely cluster).
4) Change `storageClassName` in the YAML configuration file to the name of the storage class that you want to use for storing data. It can be a local storage class or a cloud storage class, fast CSI storage class is recommended for production use.

## Step 3: Ingress configuration
By default Supervisely ships with NGINX ingress configuration, but you can manually configure your ingress controller to route traffic to Supervisely services.

## Step 4: Use the cluster to deploy Supervisely Apps
In order to let Supervisely know that you have a Kubernetes cluster available for Apps deployment, you will have to add the cluster on the `Team Cluster` page.

Please follow the instructions [here](agent.md).