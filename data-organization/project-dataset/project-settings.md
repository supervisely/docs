---
description: >-
  Configure project-level settings in Supervisely, including the labeling
  interface and Read-only mode to protect your data from accidental changes.
---

# Project Settings

Every project in Supervisely has a dedicated **Settings** tab where you can configure the labeling interface and control how the project behaves in the UI. This page covers the available settings and explains how to use **Read-only mode** to protect your project data.

## Accessing Settings

Open any project and click the **Settings** tab in the top navigation bar. The tab is divided into two sections:

- **Basic Labeling Toolbox** — general labeling preferences.
- **Advanced Labeling Toolbox** — additional options including Read-only mode.

<figure><img src="../../.gitbook/assets/project-settings/project-settings-tab.png" alt="Project Settings tab"><figcaption>Settings tab — Advanced Labeling Toolbox section</figcaption></figure>

## Read-only mode

The **Read-only project** checkbox (found under **Settings → Advanced Labeling Toolbox**) puts the project into a protected state that prevents accidental edits through the UI while keeping full access for viewing and exporting data.

### What you can do in Read-only mode

- Browse the project in the **project panel** — gallery, table view, filters, AI Search, QA & Stats — exactly as with a regular project.
- Open images or videos in the **labeling toolbox** to visualize annotations.
- **Clone** the project to another workspace.
- **Download** and export data using ecosystem apps.

### What is restricted in Read-only mode

All UI actions that modify the project or its data are disabled, including:

- Uploading or deleting images, videos, or datasets.
- Editing, adding, or removing annotations.
- Renaming or deleting the project and datasets.
- Context menu actions that change data state.

{% hint style="info" %}
**Note:** Read-only mode only restricts the UI. API access is not affected — programmatic operations via the Supervisely SDK or REST API remain fully available.
{% endhint %}

### Enabling and disabling Read-only mode

1. Open the project and navigate to **Settings → Advanced Labeling Toolbox**.
2. Check the **Read-only project** checkbox.
3. Click **Save**.

To allow editing again, uncheck the **Read-only project** checkbox and click **Save**.

You can also toggle Read-only mode programmatically using the [`set_read_only`](https://supervisely.readthedocs.io/latest/sdk/supervisely.api.project_api.ProjectApi.html?h=set_read#supervisely.api.project_api.ProjectApi.set_read_only) method of the Supervisely Python SDK.

<figure><img src="../../.gitbook/assets/project-settings/project-settings-readonly.png" alt="Read-only project checkbox"><figcaption>Enabling Read-only mode in Advanced Labeling Toolbox</figcaption></figure>

{% hint style="success" %}
**Tip:** Use Read-only mode to lock down a project after reaching a stable state, so collaborators can safely browse and export data without the risk of accidentally modifying it.
{% endhint %}
