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

   <figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_new_tag.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
**Note:** Tags for annotation objects appear when an object is selected. Tags for the entire video appear when no object is selected.
{% endhint %}

## Step 2. Adding a frame-based tag

1. **Select a frame:**
   * Navigate to the frame where the tag should start (1). 
   * Choose the tag from the **Definitions** panel by checking its box (2).

{% hint style="info" %}
**Note:** The gray area on the timeline highlights the video segment visible in the viewport, helping you navigate the time interval and understand the zoom level.
{% endhint %}

<figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_creating.png" alt=""><figcaption></figcaption></figure>

2. **Apply a value (Optional):**
   * Tags with all types of values except "None" will trigger a pop-up that prompts you to select or enter the tag value (3).
   * Apply a value and click the _**Start Range**_ button or simply press `Enter`.
   * Otherwise, select the _**Start Range Without Value**_ button or simply press `Enter`.

{% hint style="success" %}
**Tip**: Use the timeline zoom for comfortable tagging. Adjust the zoom level to magnify the frame detail up to 128x.
{% endhint %}

## Step 3. Configuring and Finalizing the Tag Range
After selecting a tag in the **Definitions** panel, the start edge of the tag range will appear in the viewport at your current cursor position and will be marked with a flag icon.

Once a tag is initiated, you can freely navigate to any frame by:
1. Clicking anywhere on the timeline, or
2. Clicking the left/right buttons next to the timeline, or
3. Entering a specific frame number, or
4. Using the arrow keys on your keyboard.

A dashed line will automatically extend to that frame.

<figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_navigation.png" alt=""><figcaption></figcaption></figure>

To complete the tag creation process and finalize the range at the desired frame:

* Click the flag icon marker at the end of the tag in the viewport, or
* Press _**Finish**_ in the **Definitions** panel.

Tags with all value types except **"None"** will trigger a pop-up prompting you to select or enter a tag value if you skipped this step when initializing the tag.

Apply a value and click the button to select:
* _**Set value & start new range**_ button or simply press `Enter`.
* _**Set value**_ button or simply press `Ctrl` `Enter`.

{% hint style="info" %}
**Note:** The number of frames the tag has been extended by is displayed next to the current tag in the **Definitions** panel.
{% endhint %}

<figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_frames_count.png" alt=""><figcaption></figcaption></figure>

You can start multiple unfinished tags as you move through the video and finalize them one by one. This is totally valid!  
All unfinished tags will dynamically extend their dashed range to the currently selected frame. You can finalize them sequentially using either a shared end frame or setting individual ones.

<figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_unfinished.png" alt=""><figcaption></figcaption></figure>

Unfinished tags remain accessible even after closing the tool, allowing others to finalize them later.

{% hint style="success" %}
**Tip**: If you don't want to choose between _**Finish and start new range**_ or _**Finish**_ every time you complete a tag, and you only need the _**Finish**_ option, go to: **Settings > Tags** and disable the option **"Display modal when finishing frame-based tag"**.{% endhint %}

<figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_settings.png" alt=""><figcaption></figcaption></figure>
 
{% hint style="success" %}
**Tip**: Use the **Default Action** setting in the pop-up to simplify repetitive actions (e.g., set "From Here to End" as the default behavior).
{% endhint %}

## Editing a Finalized Tag

#### 1. Manual Adjustment

* Hover over either edge of the tag in the viewport until the cursor changes, indicating that resizing is possible.
* Click and hold the left mouse button. Then drag to narrow or extend the tag to the desired number of frames.

#### 2. Custom Options

Click the _**Extend tag range**_ button represented by arrows pointing in opposite directions (1), next to the frame-based tag in the **Definitions** panel and choose:

* **From start to here** - Apply the tag from the beginning of the video to the current frame.  
* **Few frames forward / backward** - Apply the tag for a fixed number of frames forward or backward. Use the **+** and **−** buttons to adjust the frame count.  
* **Whole range** - Tag the entire timeline of the object.  
* **From here to end** - Apply the tag from the current frame to the end of the video.

<figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_edit_custom_options.png" alt=""><figcaption></figcaption></figure>

{% hint style="success" %}
**Tip:** Use the **Default Action** setting in the pop-up to simplify repetitive actions (e.g., set **"From here to end"** as the default behavior).
{% endhint %}

## Limiting the length of a tag

A frame-based tag can carry a minimum and a maximum length, in frames. Set them per tag in either place the tag can be defined:

* on the [project definitions](https://docs.supervisely.com/data-organization/projects/definitions) page — tick **Limit frame range tag length**, then fill **Min frames** / **Max frames**;
* in the **Create tag** dialog inside the toolbox — the two fields are shown next to **Limit frame range tag length** already, as in the screenshot at the top of this page.

<figure><img src="../../.gitbook/assets/new-tag.png" alt="" width="359"><figcaption>A tag that has to cover between 5 and 30 frames</figcaption></figure>

### Why limit it

Frame ranges are drawn by hand along a timeline, and the timeline is the one place in annotation where being slightly wrong is almost invisible. A few failure modes show up again and again in video projects:

* **Stray one-frame tags.** A mis-click on a tag checkbox creates a range that starts and ends on the same frame. Nobody notices it in the tool, and it survives into the dataset as a labelled "event" one frame long.
* **Events too short to be events.** A "lane change" or "fall" that lasts three frames is not a shorter version of the real thing — it is usually a misplaced start or end edge. Models trained on clips need a certain number of frames to have anything to learn from, and such a tag becomes noise in the training set rather than a hard example.
* **Ranges that ran away.** **From here to end** and **Whole range** are one click each and easy to hit by accident, which turns a two-second event into the rest of the video.
* **Segments that must be comparable.** When the tag feeds a metric — time in a state, event counts per minute — wildly out-of-range segments quietly distort the aggregate instead of failing loudly.

Every one of these is cheap to fix at the moment of labelling, while the labeler is still looking at the frames, and expensive to fix later: it has to be found by QA or by a script, matched back to a video, and re-opened by someone who no longer remembers the clip. A length limit turns "find it later" into "cannot be saved wrong".

Both limits are optional and independent. A minimum on its own is the common case — it rejects mis-clicks and too-short events without constraining how long a real event may run.

### How it behaves while labeling

* **Length counts inclusively.** A tag from frame 10 to frame 12 is 3 frames long, not 2.
* **Only the finished tag is checked.** You can start a range and pass through any length while it is still unfinished — the limits apply at the moment you finish it. Until then the dashed range extends freely, exactly as described above.
* **Finishing outside the limits does not go through.** The tag stays unfinished, so you can keep dragging the edge until the range is valid instead of losing the work. The number of frames next to the tag in the **Definitions** panel tells you where you are.
* **`0` means no limit.** There is no separate on/off switch: setting a field to `0` disables that side.

{% hint style="info" %}
**Note:** Limits apply to frame-based tags in video and point cloud episode projects. A **Global** tag has no range, so nothing to limit.
{% endhint %}

{% hint style="warning" %}
Setting a minimum above the maximum is refused when you save the tag — such a tag could never be finished at any length.
{% endhint %}

Existing tags are not touched when you add a limit: it applies to tags finished from that point on, so ranges recorded earlier stay as they are.

## Configuring the tag range for clearing tags

When you need to adjust or remove an existing tag's range, select the frame-based tag and uncheck it. The **"Where to Clear Tag"** modal will appear, offering several options to customize how and where the tag should be cleared.

1.  **From Tag Start to Here:** Removes the tag from the beginning of its range up to the current frame.

    Ideal for use cases where the tag should no longer apply to earlier frames but remains valid for later frames.
2. **Few Frames Forward/Backward:** Clears the tag for a set number of frames forward/backward from the current frame. Use the `+` and `-` buttons to adjust the number of frames.
3. **Whole Length:** Clears the tag across its entire range, regardless of the current frame.
4. **Clear From Here to Tag End:** Removes the tag from the current frame to the end of its range. Suitable when the tag should apply only to earlier frames and not extend to the end of the video.

### Example

**Scenario**: You want to adjust the range of a tag applied to an object but only remove part of it.

1. Select the tag in the timeline or **Definitions** panel.
2. In the **"Where to Clear Tag"** modal:

* To remove frames ahead of the current position, choose **Few Frames Forward** and set the desired number of frames.
* To clear frames leading up to the current frame, select **From Tag Start to Here**.
* For complete removal, select **Whole Length**.

3. Confirm the action by clicking the appropriate button, such as **Clear From Here to Tag End** or pressing **Enter**.

## Hotkeys

Click the **Hotkeys** menu item at the top right of the **Definitions** panel to view or customize shortcuts.

#### 1. **Timeline Navigation**
In the **Timeline** section, you'll find navigation hotkeys:

- **Go to next tag segment** - `CTRL` + `SHIFT` + `→`  
- **Go to previous tag segment** - `CTRL` + `SHIFT` + `←`

#### 2. **Tag Creation & Editing**
In the **Tags** section, you'll find hotkeys for creating and editing tags:

- **Add tag on selected frames or current frame** - `SHIFT` + `Q`  
- **Change value of the current tag segment** - `SHIFT` + `E`  
- **Remove current tag segment** - `SHIFT` + `W`

You can customize all hotkeys to fit your workflow.

<figure><img src="../../.gitbook/assets/frame-based-tagging/f-b-t_hotkeys_2.png" alt=""><figcaption></figcaption></figure>