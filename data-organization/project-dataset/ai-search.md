---
description: >-
    About AI Search: Quickly find images using semantic similarity powered by CLIP. Supports prompt-based and diverse search modes with automatic embedding updates.
---

# AI Search

**AI Search** allows users to intelligently search for images within a project or dataset using semantic similarity. It leverages **CLIP** under the hood to generate vector embeddings of images, which are stored in a dedicated embedding database (Quadrant). These embeddings are used both to process search queries and to keep the data up to date through automated or manual updates.

{% hint style="info" %}
**Note**: AI Search is only available to:
- Users with a **PRO subscription**
- Clients using **Supervised Enterprise instances**
If you do not have access, a prompt will appear suggesting you upgrade your subscription to unlock this feature.
{% endhint %}

## Enabling AI Search

When a user opens a project in Supervisely, the **AI Search** button appears at the top of the interface.

### First-time Activation

1. Click the **AI Search** button.
2. If AI Search is not yet enabled for this project, a modal dialog will appear asking if you want to enable it.
3. Upon confirmation:
    - The project is connected to the AI Search service.
    - Image embeddings for all images in the project begin generating automatically.
    - While embeddings are being prepared, search is temporarily unavailable.

{% hint style="info" %}
While embeddings are being created, the **AI Search** button shows animated **sparkling stars**.  
Once complete, the button turns **solid blue** with a star icon, indicating that the project is ready for searching.
{% endhint %}

Embeddings are updated automatically on a regular schedule. Manual updates can also be triggered via API.

## Performing a Search

After embeddings are ready, clicking the **AI Search** button opens a modal window with two available search modes:

### 1. Prompt-based Search

Search for images using a natural language prompt.

- **Description**: The system embeds your text prompt and compares it with image embeddings to find the most semantically similar images.
- **Score Chart**: After search, a distribution chart shows similarity scores between the prompt and images.
- **Filtering**: You can filter results by adjusting score thresholds directly on the chart.
- **Results Limit**: You can set how many top images to return. If the number of relevant images is lower than the limit, all available matches are shown.

**Example:**  
> _"A person riding a bicycle"_ returns images that visually and semantically match this description — regardless of labeling.

### 2. Diverse Search

Explore a representative variety of images based on the semantic structure of your dataset.

#### Available Methods:

- **Method**: Selects samples evenly across embedding clusters. Simple and balanced.
- **Diverse**: Prioritizes edge points in clusters to increase diversity. Useful for discovering edge cases and rare patterns.

No text input is required in this mode.

## Search Results and Collections

Each search creates a **collection**, which acts as a dynamic filter within your project.

- Collections contain only images that matched the query.
- They can be renamed, reused, or removed like any other filter.
- Useful for organizing search results and building datasets based on semantic criteria.

## Managing AI Search

Next to the **AI Search** button, there's a dropdown menu:

- **Disable AI Search**  
    - Disconnects the project from AI Search.
    - Embeddings will be deleted.
    - The project is removed from the auto-update queue.

{% hint style="info" %}
Embeddings are automatically refreshed on a schedule (e.g., every few days) if AI Search is enabled.
{% endhint %}