---
description: >-
  The main features, capabilities and usage recommendations of MLOps Workflow
  are described in this documentation.
---

# MLOps Workflow

MLOps Workflow streamlines the machine learning lifecycle, focusing on data version control, reproducibility, and collaboration. It provides an easy-to-use visual interface that integrates data management, experiment tracking, and model evaluation.

#### Why do you need trial tracking and version control?&#x20;

**Data evolution:** Datasets change over time, and tracking these changes is critical to maintaining model accuracy.

**Avoid confusion**: Repeated iterations can lead to errors if teams lose track of which data and model versions were used.&#x20;

**Reproducibility:** Proper tracking ensures that results can be reproduced and shared with team.

## 1. Data Version Control

Data version control simplifies managing changes in datasets throughout the project lifecycle.

**Capabilities:**

* Track changes and create backups.
* Restore previous states with a single click.
* Centralized tracking of data evolution.

**How It Works:**

* Create versions at any stage - data upload, annotation, or transformation.
* Each version is stored in a secure binary format, avoiding file duplication.
* Restore data by creating a new project version from a previous state.

> **Note:** Available only on Pro and Enterprise plans.

## 2. MLOps Workflow Visualization

The visual map shows the entire data lifecycle, including the apps and operations that modify it.

**Key Features:**

* **Data Operations:**
  * Augmentation (cropping, rotation, adding noise, etc.).
  * Annotation transformation.
  * Training data generation.
  * Dataset splitting, merging, and filtering.
* **Navigation:** Easily access data versions, projects, and application sessions.

**Example:**

1. **Data Import**: Upload and annotate images using tools like Smart Tool.
2. **Version Creation**: Capture the project's state after annotation.
3. **Model Training**: Train YOLOv10 while automatically generating checkpoints and reports.
4. **Deployment**: Apply the model to new datasets or export results.

## 3. Model Benchmarking

The platform generates automatic reports to evaluate model performance using metrics such as:

* mAP, Precision, Recall.
* Inference speed.
* Classification accuracy and IoU.

**Benefits:**

* Compare model versions to identify improvements.
* Understand how architecture or hyperparameter changes affect results.

## Building a Workflow

#### **Best Practices:**

1. **Use Projects Instead of Individual Datasets**: This improves Workflow readability.
2. **Optimize Nodes**: Combine file cards into folders to reduce redundancy.
3. **Add Descriptions**: Provide context for each Workflow element.
4. **Avoid Overwriting Node States**: Maintain a clear history of changes.
5. **Organize Session-Based Applications**: Prevent clutter and simplify Workflow structure.

### **Practical Usage**

#### **Workflow Entry Points:**

* Project context menu.
* Task context menu.
* Workspace options.

## **Integrating Workflows into Applications:**

Detailed instructions for integrating Workflows into your custom applications are available on the **Supervisely Developer Portal**.
