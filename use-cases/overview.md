# Use Cases Overview

Supervisely is a large, customizable computer vision platform for teams that need to move from raw data to production AI without stitching together disconnected tools. It combines data organization, annotation, team collaboration, neural network training, evaluation, deployment, and automation in one environment.

Different industries can use the same platform foundation and adapt it to their own constraints: data modality, annotation policy, review process, quality bar, infrastructure, and delivery requirements. Whether you work with images, videos, point clouds, medical data, or geospatial datasets, the core workflow remains consistent and extensible.

## Why This Section Exists

We created this section to document practical, end-to-end scenarios that users actually run in production.

The rest of the documentation is organized by product areas, for example [Data Organization](../data-organization/overview.md), [Labeling](../labeling/Labeling-toolbox.md), [Collaboration](../collaboration/overview.md), and [Neural Networks](../neural-networks/overview.md). This section complements those pages by showing how those capabilities come together in real use cases.

In other words, this is the "how it works together" layer of the docs.

## Platform Capabilities Behind Use Cases

- **Data foundation**: structure projects and datasets, manage metadata, and keep data lifecycle under control with [Core concepts](../data-organization/overview.md) and [Project Versions](../data-organization/project-dataset/project-versions.md).
- **Production labeling**: run annotation workflows across modalities using [Labeling Toolboxes](../labeling/Labeling-toolbox.md) and domain-specific tools.
- **AI-assisted annotation**: speed up expert workflows with [Labeling with AI](../labeling/labeling-with-AI/overview.md), including [Live Training](../labeling/labeling-with-AI/live-training/live-training.md) for iterative human-in-the-loop improvements.
- **Team operations**: coordinate at scale with [Collaboration](../collaboration/overview.md) and [Labeling Jobs](../labeling/jobs/README.md).
- **Model lifecycle**: train, evaluate, compare, and deploy models through [Neural Networks Overview](../neural-networks/overview.md), [Experiments](../neural-networks/training/experiments.md), and [Inference & Deployment](../neural-networks/inference-and-deployment/README.md).
- **Ecosystem and extensibility**: use prebuilt apps and customize pipelines via [Ecosystem](../ecosystem/ecosystem.md), SDK, and API.

## What You Will Find Here

Each use case page focuses on a concrete scenario and answers four practical questions:

1. What problem are we solving?
2. What Supervisely components are used?
3. What does the end-to-end workflow look like?
4. What outputs and operational benefits do you get?

The goal is to help teams quickly map their business problem to a proven implementation pattern inside Supervisely.

## Typical Scenarios

Common scenarios include:

- Building and maintaining large training datasets with strict quality control.
- Running distributed annotation teams with review and performance tracking.
- Using Live Training and model-assisted pre-labeling to reduce manual effort.
- Establishing repeatable model lifecycle workflows from training to deployment.
- Supporting industry-specific pipelines such as geospatial annotation and analysis.

Start with a scenario that is closest to your workflow, then follow the cross-references to dive deeper into each platform component.
