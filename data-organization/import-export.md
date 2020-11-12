# Import & Export

Supervisely supports a variety of content that can be labeled: images, videos, volumetric, medical data. That means tons of formats: .png, .jpeg, .mp4, .avi, .dicom, .pcd ... 

Moreover, there are hundreds of ways how annotations can be stored: .json, .png masks, .tfrecords, .xml and more and more.

How to handle all those cases? 😓

Thankfully, Supervisely has **Plugins** to convert data to a single **Supervisely Format** and **Agents** to run those tasks on scale.

## 🤖 Supervisely Format

When you do the labeling and data processing, images, videos and labels are stored in Supervisely database and storage servers to provide the best performance and experience.

But at some point you will need to export labeled data from Supervisely or upload already pre-annotated data.

In Supervisely data can be labeled with many different shapes from bitmaps and polygons to cuboids and custom graph structures as well as tags with pre-defined values. No existing format was there to handle all those features, so we made our own, called **Supervisely Format**.

It's a simple combination of .json files that store annotations, `meta.json` file that describes meta information about the project and (optionally) original content (images or videos). You can read more about the format [here](./Annotation-JSON-format/00_ann_format_navi.md). A quick overview of the required file structure for the upload can be found [here](./import/formats/supervisely.md)

## ⚙ Data Processing

If your data is already in the Supervisely format, you can use Supervisely API and SDK to import or export data from the platform.

Otherwise, some pre-processing may be required. What happens underhood when you upload files or click "Download as..."?

1. First, we put a new Task in the queue
2. Next available Agent downloads required data from internal storage and database and runs selected Plugin
3. Plugin does pre-processing and uploads results back to internal storage and database
4. Task ends with a link to a new Project or download archive

## 📂 Import

Let's get a quick overview of how data can be imported in Supervisely.

### Browser Upload

The most popular convenient method is just to drag-and-drop files to your browser.

- ➕ **Pros**: Web UI. Very simple. Works well for small batches (hundreds of MBs)
- ➖ **Cons**: Data should be on your PC. Slow (data has to be uploaded to the storage server first and then pre-processed on the agent)

{% page-ref page="import/upload/README.md" %}

### Agent Upload

If you have a large batch, your content is probably not on your PC and can't be drag-and-dropped. In this case you can run an Agent where your files are and upload then right from over there!

- ➕ **Pros**: Web UI. No extra steps (content is processes right away and then uploads to the storage)
- ➖ **Cons**: Files should be placed in a special folder. Requires an Agent deployed

{% page-ref page="import/agent.md" %}

### Links Plugin

But what if your dataset is so large, it cannot be upload to the platform? Well, then don't upload it at all! 🙂

There is a special import called "Links" that works a bit different — it takes a .txt files with links to the actual files (i.e. to S3 storage) and during pre-processing saves those URLs to the database. So when you will open labeling editor, images or videos will be loaded to your browser directly from those URLs.

- ➕ **Pros**: Web UI. Fastest import.
- ➖ **Cons**: You are in charge of your own storage. Files are not cached and will be download every time we need them

{% page-ref page="import/links/README.md" %}

### Python SDK

Best option if you want to automate import process and know just a little bit a Python. Our SDK wraps all the hard work and provides simple and clean interface to upload you data to the platform.

- ➕ **Pros**: Full automation and customization. The fastest method. No Agent required.
- ➖ **Cons**: No UI. Requires Python and coding skills.

{% page-ref page="/sdk.md" %}

### HTTP API

The most direct way to do the job. No wrappers, no agents, just old simple JSON-RPC like HTTP API.

- ➕ **Pros**: Full automation and customization. Any coding language. The fastest method. No Agent required.
- ➖ **Cons**: No UI. Requires coding skills.

{% page-ref page="/sdk.md" %}

## 📥 Export

Labeling is done, now you want your content and labels back. How to download them?

### Web Interface

In the Projects content menu you will find "Download as..." option. This is actually a list Python Scripts that have word "Download" in its name. So when you click on it, a new task is deployed to an agent and a Python Script pull all the data is needed from the storage and database.

We've already prepared a couple of scripts that saves data in the [Supervisely Format](supervisely-format.md) and, for some project types, and extra scripts (like masks generation script for images).

{% hint style="info" %}
Enterprise Edition users can create their own Python Scripts to download Project in desired format.
{% endhint %}

### API & Python SDK

Just like with the import, you can automate export process with the help of our API and SDK.
