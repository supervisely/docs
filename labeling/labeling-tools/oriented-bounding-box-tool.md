---
description: >-
  In this guide, you'll learn how to use oriented-bounding-box tool for video.
---

# Oriented Bounding Box Tool

## What is Oriented Bounding Box Annotation Tool?

An Oriented Bounding Box (OBB) is a rotated rectangle defined by two corner points and a rotation angle. Unlike an axis-aligned rectangle, an OBB can be rotated to closely fit objects at arbitrary orientations. This makes it especially suitable for annotating elongated or tilted objects such as vehicles, ships, or text.

{% embed url="https://youtu.be/tGA1-EJOyt4" %}

## How to use the Bounding Box

To speed up the annotation process, the Oriented Bounding Box tool can be used together with the Auto Track model.

### Setup

1. In the main menu, go to App Ecosystem and start Auto Track.
<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-1.jpg" alt=""><figcaption></figcaption></figure>

2. Then open Tasks & Apps from the main menu.
Navigate to the Apps tab.
Find the recently launched Auto Track application and click Open.
<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-2.jpg" alt=""><figcaption></figcaption></figure>

3. You will be redirected to the settings page containing all annotation tools compatible with Auto Track.
Scroll down to the Oriented Bounding Box section.
In the Select model for predictions dropdown, choose Interpolation (No model).
Return to the labeling tool.
<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-3.jpg" alt=""><figcaption></figcaption></figure>

### Usage Scenarios - Automatic annotation across frames.

<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-4.jpg" alt=""><figcaption></figcaption></figure>

In the Quick Actions section of the Auto Track settings, there is an option to automatically apply annotations to any desired number of frames in either direction from the frame where the object was annotated using the Oriented Bounding Box tool.

For Auto Track to work, at least two consecutive frames must be manually annotated. The underlying principle is as follows: the model compares the annotation on one frame with the annotation on another frame, calculates the differences in rotation angle, size, and position of the oriented bounding box, and then propagates these differences forward or backward, creating bounding boxes on subsequent frames as if by inertia.

This simple method can be used on a small number of frames to quickly verify the correctness and consistency of the annotation.

### Usage Scenarios - Interpolation between keyframes.

The most effective use of the Oriented Bounding Box together with Auto Track is achieved using the Interpolate until next real frame function. This allows the system to automatically interpolate object positions and orientations between manually annotated keyframes.

Let’s consider an example of annotating a vehicle moving along a complex trajectory with changes in body orientation.

{% hint style="info" %}
**Note:** For interpolation to work correctly, Auto Track must be disabled in the Settings.
{% endhint %}

<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-5.jpg" alt=""><figcaption></figcaption></figure>

1. First, annotate the object on any desired frame using the Oriented Bounding Box tool. This annotation will serve as the starting point for automatic interpolation.

<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-6.jpg" alt=""><figcaption></figcaption></figure>

2. Next, move to another frame that will act as the final frame in the sequence forming the object’s motion trajectory, and annotate the object there as well.

3. After that, click Interpolate until next real frame. As a result, a fully annotated segment will appear on the timeline, covering all frames between the first and the last manually annotated frames.

<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-7.jpg" alt=""><figcaption></figcaption></figure>

The Interpolate until next real frame function evenly interpolates all parameters between the first and last annotated bounding boxes — including rotation angle, size, and position — across all intermediate frames.

{% embed url="https://youtu.be/tGA1-EJOyt4" %}

### Additional Use Case

Consider another scenario using the same function.
If the object is manually annotated on three frames that are not adjacent, and you then navigate to an annotated frame located between the two outermost ones and apply Interpolate until next real frame, the system will automatically annotate all frames in both directions, up to the two nearest manually annotated frames.

<figure><img src="../../.gitbook/assets/oriented-b-box/oriented-bbox-8.jpg" alt=""><figcaption></figcaption></figure>