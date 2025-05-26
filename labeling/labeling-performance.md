---
description: >-
  Learn how to use the Labeling Performance page in Supervisely to track team efficiency, monitor annotation quality, and gain actionable insights with powerful, customizable analytics.
---

The **Labeling Performance** page is a powerful analytics tool designed to provide detailed statistics about the data annotation process within your projects. It helps you track team efficiency, monitor each member’s contributions, identify bottlenecks, manage annotation quality, and make informed decisions based on real data.

## Why it’s beneficial to use Supervisely statistics

Unlike competitors, **Supervisely** provides an extended analytics system that allows users to analyze labeling performance across the entire team and all projects simultaneously. This system is available absolutely free of charge for all users, including those on the Free plan.
The platform offers a wide range of filters to enable flexible, personalized, and in-depth analytics. This is especially valuable for companies and teams looking to improve annotation processes, utilize resources efficiently, and increase the quality of data used for training AI models.

### How to use the Labeling Performance page

**Filters**
In the upper-right corner of the page, you’ll find several filters that directly affect the data shown in all the charts:

* Time period filter
* Data type filter (images, videos, DICOM volumes, point clouds, point cloud episodes)
* Project filter
* Labeling Job filter

These filters allow you to finely customize the statistics for your specific needs and obtain the most relevant data for your analysis.

**Track progress or regress**
You can quickly and visually monitor performance progress or decline for the selected time period, compared to a previous period, without switching the time filter. This helps identify trends and evaluate process efficiency instantly.

All the following chart sections follow the same structure:

1. The large number at the top represents the main quantitative value of the parameter for the period selected in the filter.

2. To the right of this number is a percentage comparison showing how much better or worse the current value is compared to the average for a longer reference period (usually the next available time interval in the filter list).

3. Below, the chart itself also displays this longer reference period, where each bar represents the parameter’s value for the same interval selected in the filter — just like the large number above.

<figure><img src="../.gitbook/assets/labeling-performance/lp-main-princip.png" alt=""><figcaption></figcaption></figure>
<br>
<br>
<br>

## Chart explanations

### 1. Status of Assets

**What it shows:**<br>
How many assets (images, videos, DICOM volumes, point clouds) in labeling jobs and queues changed their labeling status during the selected period.

**Asset Statuses Explained:**
  * **Pending** — The asset is waiting to be annotated. It has been assigned but no annotation has been started yet.
  * **Submitted** — The asset has been annotated and sent for review. It is now pending approval from a reviewer.
  * **Rejected** — The asset was reviewed and rejected. It has been sent back to the annotator for revision or correction.
  * **Accepted** — The asset has been reviewed and approved. No further changes are required.

{% hint style="info" %}
**Note**: Status changes don’t always mean the annotations themselves were edited. For example, an asset may change status without actual label updates, and vice versa.
{% endhint %}

**Advantages:**<br>
Allows you to track annotation progress and measure general team activity across projects.

<figure><img src="../.gitbook/assets/labeling-performance/lp-assets-status.jpg" alt=""><figcaption></figcaption></figure>
<br>

### 2. Objects Section

At the top of this section, you can see the total number of **annotation objects** created during the selected period, along with two charts:

  **1. Bar chart** "Classes distribution among objects"<br>
  **2. Scatter chart** "Classes distribution among objects"

What is an **annotation object**?<br>
An annotation object is an individual element on an image, video, or other data type that has been highlighted and described using annotation tools.
Examples of annotation objects include:

  * A person marked with a bounding box on an image
  * A car annotated using a polygonal mask
  * A tumor on a medical scan marked with a brush
  * A tree in a 3D point cloud highlighted with a cuboid

  **Each annotation object typically:**
  * Belongs to a specific **class** (e.g., “car”, “pedestrian”)
  * Has a defined **geometry** (bounding box, mask, polygon, etc.)
  * May include **tags** (e.g., “color: red”, “moving”)

### Bar chart

**What it shows:**<br>
A list of objects sorted by the class they belong to, ordered by descending count of objects in each class.

**Advantages:**<br>
Helps you understand which object classes appear most frequently in your annotations.
When a specific project is selected via filters, this chart becomes a valuable tool for analyzing class balance in your dataset. Balanced data is critical for training accurate and fair AI models.

### Scatter chart

This chart includes 4 variables:

1. Y-axis: Number of objects
2. X-axis: Time period
3. Dots: Classes
4. Dot color: Corresponds to the class and the geometry color used for annotation

**Advantages:**<br>
Provides insights into the volume and frequency of object creation by class over time. It helps identify peaks or gaps in annotation activity.

**Interactivity:**<br>
The bar chart list "Classes distribution among objects" and the scatter chart "Classes distribution among objects" are interconnected and interactive. You can select one or multiple classes by holding the Command key (⌘) or Control key (Ctrl) in the bar chart list, and only the selected classes will be displayed in the scatter chart as well. This mode is useful for comparing only the classes that are relevant to your analysis.
<br>
<br>

### 3. Assets

**What it shows:**<br>
The number of assets (images, videos, DICOM volumes, point clouds) that had annotation activity (e.g., label creation or editing) during the selected period.

**Advantages:**<br>
Enables you to evaluate the overall annotation workload and how productivity changes over time.
<br>
<br>

### 4. Labeling Actions

**What it shows:**<br>
Total number of labeling actions, including object creation (bounding boxes, polygons, etc.) and tag assignments.

**Advantages:**<br>
Provides a detailed view of actual annotation activity, independent of asset status.
<br>
<br>

### 5. Team Activity Heatmap

**What it shows:**<br>
Annotator activity within the current team, measured by the number of labeling actions per day.

**Advantages:**<br>
Identifies spikes and drops in team activity. Useful for workload management and performance evaluation.
<br>
<br>

### 6. Labeling Time

**What it shows:**<br>
Total time each team member spent working in the annotation interface. This only includes active work time on labeling jobs or queues. Time outside jobs or during inactivity (more than 5 minutes of no action) is excluded.

**Advantages:**<br>
Helps understand how much real, productive time the team spends on annotation, not just how long the interface was open.
<br>
<br>

### 7. Labeling Speed

**What it shows:**<br>
The annotation speed in objects per hour (objects/h).

**Advantages:**<br>
Helps assess efficiency and compare performance among team members.
<br>
<br>

### 8. Average Time per Object

**What it shows:**<br>
Displays the **average labeling time** spent per object:<br>
**Avg Time per Object = Total labeling time / Total number of objects**

**Usage:**

* Evaluate overall team performance
* Identify efficiency issues
* If the average time per object is too high, it may indicate complex tasks, workflow problems, or the need for additional training for the team or specific members.
<br>
<br>

### 9. Acceptance Rate

**What it shows:**<br>
The percentage of assets accepted during the review stage in Labeling Jobs.

**Formula:**<br>
`Acceptance Rate (%) = (Accepted assets / Total assets) * 100`

**Advantages:**<br>
A key metric for assessing annotation quality.
<br>
<br>

### 10. Review Time

**What it shows:**<br>
Total time spent on asset reviews.

**Advantages:**<br>
By comparing this with Labeling Time, you can calculate how much time was spent specifically on annotation (i.e., `Labeling Time - Review Time`).
<br>
<br>

### 11. Average Review Time

**What it shows:**<br>
The average review time per label (figure or tag).

**Formula:**<br>
`Avg Review Time = Total Review Time / Number of labels reviewed`

**Advantages:**<br>
Helps measure reviewer workload and review process efficiency.
<br>
<br>

### 12. Members Performance Table

An essential table that displays statistics for each individual team member.

**What it shows:**

* **Member Login**
* **Created Objects** – number of objects created by the member during the selected period
* **Created Tags** – number of tags assigned by the member during the selected period
* **Labeling Speed** – number of objects annotated per hour
* **Assets Accepted (%)** – acceptance rate for assets reviewed
* **Assets Accepted (count)** – number of accepted assets
* **Performed Reviews** – number of assets reviewed by the member (as a reviewer)
* **Submitted Assets** – number of assets submitted for review (as an annotator)
* **Labeling Time (min)** – total active time spent in the annotation interface
* **Member ID**

**How to use it:**<br>
If other charts show a drop in labeling performance, you can use this table to identify members with low metrics. Simply sort the table (using the sort icon next to each column header) to find users with the lowest speed or quality (Acceptance Rate).

<figure><img src="../.gitbook/assets/labeling-performance/lp-member-performance1.jpg" alt=""><figcaption></figcaption></figure>
<br>


### 13. Class and Tag Statistics Table

This table consolidates statistics by **class** or **tag**. By default, class statistics are shown. To view tag data, click “Tag” in the table header.

**In Class mode:**

* **Class name**
* **Objects** – number of objects assigned to the class
* **Assets** – number of assets (images, videos, etc.) containing this class
* **Labeling Time per Object (seconds)**
* **Total Labeling Time (minutes)**

**In Tag mode:**

* **Tag name**
* **Objects** – number of objects assigned this tag
* **Entities** – number of assets (images, videos, etc.) containing this tag.

<figure><img src="../.gitbook/assets/labeling-performance/lp-class-class.jpg" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/labeling-performance/lp-class-tag1.jpg" alt=""><figcaption></figcaption></figure>