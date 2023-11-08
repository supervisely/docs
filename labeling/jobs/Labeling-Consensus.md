# Labeling Consensus


Consensus labeling is an annotation approach when multiple annotators collaboratively label the same set of images independently and the resulting annotation is based on combining labels with one of the consensus algorithms like, for example, the well-known majority voting. This approach is not limited to specific computer vision tasks and can be used for object detection, semantic and instance segmentation, classification and others.

Traditionally all annotators are compared with each other and the consensus scores are calculated for every possible pair of labelers. These consensus scores measure the agreement between labels and show how similar different annotations are. This metric can have any value between 0 % to 100 %. In case there are 2 completely different annotations the consensus for an image would be 0 %. If annotations are identical - the score would be 100 %. The higher values of the score show that annotations are more similar.

![](Labeling-Consensus.png)

{% hint style="info" %}
Example above is Labeling Consensus [application](https://ecosystem.supervisely.com/apps/consensus?utm_source=blog) from our Ecosystem.
{% endhint %}

{% hint style="info" %}

Learn more about Labeling Consensus in [How to use labeling consensus to get accurate training data](https://supervisely.com/blog/labeling-consensus) tutorial.

{% endhint %}

## Step-By-Step Guide

{% embed url="https://www.youtube.com/watch?v=a9psonpLPIw&ab_channel=Supervisely" %}  {% endembed %}
