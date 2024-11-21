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
   * Navigate to the **Definitions** panel and locate the tags under the **Frame-based Tags** section. Here is a list of tags you have already created.

{% hint style="info" %}
**Note:** Tags for annotation objects appear when an object is selected. Tags for the entire video appear when no object is selected.
{% endhint %}

## Step 2. Adding a frame-based tag

1. **Select a frame:**
   * Navigate to the frame where the tag should start.
   * Choose the tag from the [Definitions panel](../labeling-toolbox/videos-3.0.md#definitions-panel) by checking its box.
2. **Apply a value (Optional):**
   * Open the [Video Labeling Toolbox](../labeling-toolbox/videos-3.0.md).
   * If the tag requires a value (e.g., "High," "Stopped"), select it from the dropdown.

## Step 3. Configuring the tag range

After selecting the tag, a pop-up window will appear, offering several ways to define the tag's range. Choose the option that best fits your needs:

1. **Select** **Range (Default)**:
   * This method allows the tag range to grow dynamically as you move through the video.
   * Press _**Finish**_ in the **Definitions** panel or hit `Enter` to finalize the range at your desired position.
2.  **From Here to End**:

    * Apply the tag from the current frame to the end of the video.
    * To stop the tag earlier, uncheck the tag on the desired frame. A pop-up will allow you to adjust the range accordingly.

    <mark style="color:green;">**Note:**</mark> You can start multiple unfinished tags as you move through the video and finish them one by one. This is totally valid!

    <mark style="color:green;">**Note:**</mark> Unfinished tags remain accessible even after closing the tool, allowing others to finalize them later.
3. **Custom Options**:
   * **Add Unfinished**: Start the tag but finalize its range later.
   * **Few Frames Forward/Backward**: Apply the tag for a fixed number of frames forward or backward. Use the `+` and `-` buttons to adjust the frame count.
   * **Whole Length**: Tag the entire timeline of the object.
   * **Labeled Frames**: Apply the tag only to frames where the object is already annotated.

{% hint style="success" %}
**Tip**: Use the **Default Action** setting in the pop-up to simplify repetitive actions (e.g., set "From Here to End" as the default behavior).
{% endhint %}

### Editing Tags

Select the tag in the **Definitions** panel to modify its range or value.&#x20;

## Example

You need to tag a car (_Object ID: 482_) as moving out of its lane:

1. Select the car in the objects list.
2. Find the **Lane Change** tag in the **Definitions** panel.
3. Choose the value **Off-lane** from the dropdown.
4. In the pop-up window, select **Few Frames Forward** and set the range to 10 frames.
5. Confirm the action and review the timeline.

## Configuring the tag range for clearing tags

When you need to adjust or remove an existing tag's range, the **"Where to Clear Tag"** modal offers several options to customize how and where the tag should be cleared.

1.  **From Tag Start to Here:** Removes the tag from the beginning of its range up to the current frame.

    Ideal for use cases where the tag should no longer apply to earlier frames but remains valid for later frames.
2. **Few Frames Forward/Backward:** Clears the tag for a set number of frames forward/backward from the current frame. Use the `+` and `-` buttons to adjust the number of frames.
3. **Whole Length:** Clears the tag across its entire range, regardless of the current frame.
4. **Clear From Here to Tag End:** Removes the tag from the current frame to the end of its range. Suitable when the tag should apply only to earlier frames and not extend to the end of the video.

## Example

**Scenario**: You want to adjust the range of a tag applied to an object but only remove part of it.

1. Select the tag in the timeline or **Definitions** panel.
2. In the **"Where to Clear Tag"** modal:

* To remove frames ahead of the current position, choose **Few Frames Forward** and set the desired number of frames.
* To clear frames leading up to the current frame, select **From Tag Start to Here**.
* For complete removal, select **Whole Length**.

3. Confirm the action by clicking the appropriate button, such as **Clear From Here to Tag End** or pressing **Enter**.
