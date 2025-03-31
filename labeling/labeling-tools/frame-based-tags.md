---
description: >-
  Frame-based tagging is a crucial task in video annotation, allowing tags to be
  assigned to specific frame ranges or multiple intervals.
---

# Frame-based tagging

While applying a tag to a specific label object or video file can be useful, it gets a bit tricky when it comes to assigning a tag (often with a value) to a range of frames or multiple ranges. This short guide will help you learn **how to efficiently apply frame-based tagging** in Supervisely.

## Step 1. Preparing and locating tags

1. **Define tags in the project**:
   * Go to the [project definitions](https://docs.supervisely.com/data-organization/projects/definitions) page.
   * Create the required tags and set their scope to **Global and Frame-based** or **Frame-based**.
2. **Find tags in the Video Labeling Toolbox**:
   * Open the [Video Labeling Toolbox](../labeling-toolbox/videos-3.0.md).
   * Navigate to the [Definitions panel](../labeling-toolbox/videos-3.0.md#definitions-panel) and locate the tags under the **Frame-based Tags** section. Here is a list of tags you have already created.
3. **Define or add tags directly in the Labeling Toolbox**:
   * Find the mini button _**+**_ in the top right corner of the **Definitions** panel.
   * Click on it and select _**Create tag**_.

{% hint style="info" %}
**Note:** Tags for annotation objects appear when an object is selected. Tags for the entire video appear when no object is selected.
{% endhint %}

## Step 2. Adding a frame-based tag

1. **Select a frame:**
   * Navigate to the frame where the tag should start.

      For this purpose, use the timeline zoom for comfortable tagging. Adjust the zoom level to magnify the frame detail up to 128x.
   * Choose the tag from the **Definitions** panel by checking its box.

   <mark style="color:green;">**Note:**</mark> The gray area on the timeline highlights the video segment visible in the viewport, helping you navigate the time interval and understand the zoom level.

2. **Apply a value (Optional):**
   * Tags with all types of values except "None" will trigger a pop-up that prompts you to select or enter the tag value.
   * Apply a value and click the _**Start Range**_ button or simply press `Enter`.
   * Otherwise, select the _**Start Range Without Value**_ button or simply press `Enter`.

## Step 3. Configuring and finalizing  the tag range

After selecting a tag, the start edge of the tag range will appear in the viewport at your current cursor position and will be marked with a flag icon.

From this point, there are several scenarios for configuring the tag range:
1. **Manually extending the tag range in the viewport**:
   * Hover over the start edge of the tag in the viewport until the cursor changes, indicating that resizing is possible.
   * Click and hold the left mouse button. Then drag to extend the tag to the desired number of frames.
   
      A dashed line will appear, indicating the length of the unfinished tag.

   * To complete the tag creation process and finalize the range at your desired position, click the flag icon marker at the end of the tag in the viewport or press _**Finish**_ in the **Definitions** panel.
   * Tags with all types of values except "None" will trigger a pop-up prompting you to select or enter the tag value if you skipped this step when initializing the tag.
   * Apply a value and click the _**Start Range**_ button or simply press `Enter`.

   <mark style="color:green;">**Note:**</mark> The number of frames the tag was extended by is displayed next to the current tag in the **Definitions** panel.
2. **Dynamically extending the tag range in the viewport**:
   * Press `Enter` to initialize video playback and see the tag range grow dynamically as you move through the video.
   * Press `Enter`  again to stop video playback and complete the tag extension.
   * Press _**Finish**_ in the **Definitions** panel or click the flag icon marker at the end of the tag in the viewport to finalize the range at your desired position.
3. **Custom Options**:

   Press the _**Extend tag range**_ button (represented by arrows pointing in opposite directions) next to the frame-based tag in the **Definitions** panel and select:
   * **From start to here**: Apply the tag from the current frame to the beginning of the video.
   * **Few frames forward / backward**: Apply the tag for a fixed number of frames forward or backward. Use the `+` and `-` buttons to adjust the frame count.
   * **Whole range**: Tag the entire timeline of the object.
   * **From here to end**: Apply the tag from the current frame to the end of the video.
   
<mark style="color:green;">**Note:**</mark> You can start multiple unfinished tags as you move through the video and finish them one by one. This is totally valid!

<mark style="color:green;">**Note:**</mark> Unfinished tags remain accessible even after closing the tool, allowing others to finalize them later.

{% hint style="success" %}
**Tip**: Use the **Default Action** setting in the pop-up to simplify repetitive actions (e.g., set "From Here to End" as the default behavior).
{% endhint %}

## Editing Tags

To edit frame-based tags, use the same methods as when creating them.

### Example

You need to tag a car (_Object ID: 482_) as moving out of its lane:

1. Select the car in the objects list.
2. Find the **Lane Change** tag in the **Definitions** panel.
3. Choose the value **Off-lane** from the dropdown.
4. In the pop-up window, select **Few Frames Forward** and set the range to 10 frames.
5. Confirm the action and review the timeline.

## Configuring the tag range for clearing tags

When you need to adjust or remove an existing tag's range, select the frame-based tag and uncheck it. The **"Where to Clear Tag"** modal will appear, offering several options to customize how and where the tag should be cleared.

1. **Whole Length:** Clears the tag across its entire range, regardless of the current frame.
2. **Clear From Here to Tag End:** Removes the tag from the current frame to the end of its range. Suitable when the tag should apply only to earlier frames and not extend to the end of the video.