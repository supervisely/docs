# Labeling Jobs

Labeling jobs is a powerful tool for efficiently organizing and distributing data annotation tasks within a [team](../../collaboration/teams.md). It is designed to ensure that annotators work on well-defined and manageable portions of the [dataset](/broken/pages/-M54fC5lCGh1KuU-VTCW), follow consistent guidelines, and contribute to the overall success of the annotation project while maintaining data quality and accuracy. It is a critical component of effective team coordination in data annotation efforts.

{% hint style="info" %}
Learn more about Labeling Jobs in [Mastering Labeling Jobs: Your Ultimate Guide.](https://supervisely.com/blog/labeling-jobs)
{% endhint %}

* **Annotation Quality Control**: ✅ Includes inspections and options for re-labeling when necessary.
* **Task Distribution**: Prevents overlap by assigning jobs to specific team members.
* **Consistent Guidelines**: 📜 Eliminates subjective errors through clear technical requirements and restrictions.
* **Real-Time Monitoring**: 🕒 Tracks progress and allows iterations to improve results.
* **Acess Control:** 🔒 Limits access to specific datasets as needed.

***

### Roles in Labeling Jobs

Roles define team members’ responsibilities and permissions within the annotation process. Each member is assigned a role on the Members page, and a single user can have different roles across teams.

#### 📋 Manager

**Responsibilities**: 🛠️

* Creates and manages Labeling Jobs.
* Provides detailed task descriptions in the Info section.
* Monitors progress and analyzes team performance statistics.
* Assigns tasks to Annotators and Reviewers.

**Permissions**: 🔑

* Full access to manage the annotation process and review statistics.

***

#### **✍️** Annotator (Labeler)

**Responsibilities**: 🛠️

* Labels assigned data following predefined instructions.
* Submits completed jobs for review.

**Permissions**: 🔑

* Access limited to the Labeling Jobs page.
* Cannot create classes, use other applications, or Neural Networks.

***

#### 🔍 Reviewer

**Responsibilities**: 🛠️

* Reviews annotations and sends jobs for re-labeling if needed.
* Can create Labeling Jobs and analyze statistics.

**Permissions**: 🔑

* Access to review and finalize jobs or send them for re-annotation.

***

## Using Labeling Jobs: Step-By-Step Guide

{% hint style="info" %}
**Before you start**

Make sure that you have:

* dedicated Team assigned with proper roles
* necessary projects for annotation with relevant properties (clasess/figures/tags) defined
{% endhint %}

### Step 1. Create a Labeling Job

1. Navigate to the Labeling Jobs tab. 🗂️
2. Assign a title and provide a detailed description for Annotators.
   * Use Markdown or Labeling Guides for detailed instructions with images or videos.
3. Assign Reviewers and Annotators.
4. Select the data to annotate.
5. Define available classes, tags, and any restrictions (e.g., max figures per item).
6. Filter data by criteria like tags or item count. By default, the entire dataset is selected for annotation.
7. Complete setup to redirect to the Labeling Jobs page, where tasks are listed for each Annotator.

### Step 2. Complete the Job

Annotators should:

1. Read technical specifications.
2. Use the annotation toolbox to label data with predefined classes.
3. Confirm the task is completed and submit it for review.
4. Once submitted, the job is marked as completed and removed from the Annotator’s list.

### Step 3. Review and Quality Control

Reviewers follow these steps:

1. Read technical specifications.
2. Review annotations in the annotation toolbox. 🛠️
   * Accept (👍) or Reject (👎) the work.
3. Finalize the Labeling Job if all data is reviewed.
   * Rejected annotations are sent for re-annotation in a new Labeling Job. 🚀

***

### Labeling Job Statistics

Managers and Reviewers can click the **Stats** button to view performance statistics for each Labeling Job.

***

### Video Tutorial

Watch our concise video tutorial 🎥 to unlock the full potential of collaboration using **Labeling Jobs** on the Supervisely platform.

{% embed url="https://www.youtube.com/watch?v=YwNHbvyZL7Q&ab_channel=Supervisely" %}
Video guide
{% endembed %}

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Labeling Queues</strong></td><td>Labeling Queues is a systematic method for distributing and managing labeling process in a team, where labeling tasks are grouped into queues and sequentially distributed among annotators.</td><td><a href="Labeling-Queues.md">Labeling-Queues.md</a></td></tr><tr><td><strong>Labeling Consensust</strong></td><td>Consensus labeling is an annotation approach where multiple annotators jointly label the same set of images independently.</td><td><a href="Labeling-Consensus.md">Labeling-Consensus.md</a></td></tr><tr><td><strong>Labeling Statistics</strong></td><td>Understanding your data is extremely important if you want to have precise annotations and consistent training data.</td><td><a href="Labeling-Statistics.md">Labeling-Statistics.md</a></td></tr></tbody></table>
