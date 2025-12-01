# Deployment Options

Supervisely Enterprise Edition provides flexible deployment options to meet your organization's infrastructure, security, and compliance requirements. Choose the deployment model that works best for your use case.

## Self-Hosted Deployment

Deploy and run Supervisely entirely within your own infrastructure.

### Your Cloud Environment
Run Supervisely in your own cloud (AWS, Azure, Google Cloud, etc.) with complete control over the environment.

- **Complete isolation**: Platform runs entirely within your cloud infrastructure
- **No external dependencies**: Data never leaves your environment during operation
- **Flexible hosting**: Works with any cloud provider or on-premises setup

### On-Premises Infrastructure
Install Supervisely on your own servers and data centers.

- **Full control**: Complete ownership of hardware and software stack
- **Identical functionality**: Works the same as cloud deployments
- **Multiple deployment options**: Bare metal, VMs, or Kubernetes clusters

**Getting Started**: Follow our [Installation Guide](../installation/) for step-by-step setup instructions.

## Managed Hosting

Let Supervisely handle the infrastructure while you focus on your data and models.

### Dedicated Private Instance
We deploy and manage a private Supervisely instance exclusively for your organization.

- **Fully isolated**: Dedicated environment accessible only to your team  
- **Managed maintenance**: We handle deployment, security, backups, and updates
- **Flexible locations**: Multiple regions available to meet data residency requirements
- **Professional support**: Full deployment and ongoing operational support

**Contact us** to discuss your requirements and preferred server location.

## Hybrid Configuration

Combine managed platform access with your own compute and storage resources.

### Connect Your Hardware
Use any GPU hardware for processing while accessing Supervisely's platform.

- **Bring your own compute**: Office servers, cloud instances, or data center hardware
- **Universal compatibility**: Works with any provider or on-premises setup
- **Simple setup**: Connect via our [agent installation guide](../../getting-started/connect-your-computer/)

### Your Cloud Storage
Keep data in your own cloud storage while working through Supervisely.

- **Data stays put**: Files remain in your environment without duplication
- **Direct integration**: Work with data seamlessly through the platform
- **Supported providers**: AWS S3, Azure Blob Storage, Google Cloud Storage, and more

Learn more about [cloud storage integration](../s3/).

## Special Features

### Offline Mode
For environments requiring complete air-gapped operation.

- **Zero internet connectivity**: Operate without any external connections
- **Complete isolation**: Perfect for high-security environments
- **Availability**: Enterprise Premium edition and above (not available in Enterprise Light)

See our [offline usage documentation](../offline-usage/) for setup details.

### Network Requirements
Most deployments require limited external connectivity for:

- **License validation**: Initial activation with Supervisely's license server
- **Container registry**: Downloading application containers for platform features

For detailed network configuration, see our [firewall requirements](../firewall/).

## Edition Overview

| Feature | Enterprise Light | Enterprise Premium | Community Edition |
|---------|------------------|-------------------|-------------------|
| Self-Hosted Deployment | ✅ | ✅ | ❌ |
| Managed Hosting | ✅ | ✅ | ✅* |
| Offline Mode | ❌ | ✅ | ❌ |
| External Compute | ✅ | ✅ | ✅ |
| Cloud Storage Integration | ✅ | ✅ | ❌ |

*Community Edition is available as SaaS (hosted in Germany)

## Next Steps

**Self-Hosted**: Start with our [Installation Guide](../installation/)  
**Managed Hosting**: Contact us to discuss your deployment requirements  
**Hybrid Setup**: Begin by [connecting your compute resources](../../getting-started/connect-your-computer/)  
**Cloud Storage**: Configure [cloud storage integration](../s3/) after deployment

Choose the option that best fits your organization's needs, and our team is here to help with any questions about deployment options or technical requirements.