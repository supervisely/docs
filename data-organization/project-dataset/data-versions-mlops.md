---
description: >-
  The main features, capabilities and usage recommendations of MLOps Workflow are described in this documentation.
---

# What is MLOps Workflow in Supervisely

**MLOps Workflow** in Supervisely helps you:

1. **Track data changes** – create versions of a project and monitor what changed and when.
2. **Ensure experiment reproducibility** – return to an exact state of data and models.
3. **Collaborate as a team** – see how the project evolved and who ran what.
4. **Understand the process easily** – visualize the entire data/model pipeline.

## 1. Data Version Control

- You can save any project state (after uploading, annotating, filtering, etc.) as a **version**.
- Versions are created **automatically** when you run apps like TrainYOLO or other training-related apps.
- This ensures you can **reproduce an experiment** later using the same data state.
- You can also **manually create a version**, but **only if there were changes** in the data. Otherwise, it won’t make sense and the system will prevent it.
- The **only exception** is the first version — you can always create it because there’s no prior state to compare to.
- While versions **can be deleted**, it is **not recommended** — the project history might be lost.
- You may notice **intermediate versions** in the MLOps Workflow graph, but they are just **visual indicators** and do not appear in the project’s version tab.

## 2. Visualizing the Full Process

- The interface shows a **graph** – with blocks representing data and applications.
- A block may represent data (projects, datasets, files) **before or after processing**, or an operation/app.
- Example: upload images → save version → train YOLO → get model and report → create a new version.
- Each step is clickable — you can view, download, or recover results at any point.

## 3. Model Evaluation (Benchmarking)

- After training, you automatically get a report with:
  - mAP, Precision, Recall, IoU
  - Inference speed, and more
- These metrics help you compare different models or data setups.
- Easy side-by-side comparison of model versions.

## 4. Workflow Building – Best Practices

- Prefer working with **projects**, not just datasets — the graph will be easier to follow.
- **Group related steps** (e.g., apps in folders).
- Add **descriptions** to blocks — teammates will understand your logic faster.
- Avoid **overwriting existing versions** — keep the process traceable.
- When launching apps, **preserve session context**, don’t run everything in one long chain.

## 5. Getting Started

You can open the MLOps Workflow interface from:
- The **project menu**
- **Tasks** section
- Directly from the **workspace**

## 6. Integrating Workflow into Custom Applications

If you're building your own app using the Python SDK:

- Initialize with:
  ```python
  api = Api.from_env()

This will enable api.app.workflow in your app context.

Then use methods like:
```
  api.app.workflow.add_input_project(project, version_id=...)
api.app.workflow.add_output_project(...)
```

These calls add blocks to the workflow graph showing your app’s input/output.

There are also methods for datasets, files, sessions, labeling jobs, etc.

It’s a simple way to visualize your app’s logic in the MLOps Workflow.

## 7. Why Data Versioning Matters

To summarize:

Automatic versions are created by training-related apps (e.g., TrainYOLO).

- Manual versions require data changes to be saved.

- Version 1 can always be created — it’s your baseline.

- Deleting versions is possible but not encouraged.

- Intermediate versions may appear in the graph view but not in the project’s version list — they are for orientation only.

## Why MLOps Workflow Is Important

- Enables you to revert to any data state when needed.

- Helps analyze performance — what change made the model better?

- Simplifies teamwork — every step is visible.

- Speeds up development and delivery — everything is traceable and repeatable.