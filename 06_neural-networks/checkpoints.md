## Overview

During training several snapshots of a model are saved and can be retrieved after the training process is finished. This can be useful to understand training dynamics and select the best available model for further use.

## Example

Suppose that we have run the training process and a corresponding task was created and finished. 

![](../assets/legacy/nn/checkpoints/check_task.png)

In the context menu assotiated with the task there is a "Checkpoints" item that gives you access to all the checkpoints that were created during the training process.

![](../assets/legacy/nn/checkpoints/check_create.png)

After clicking on the "Checkpoints" item the checkpoint list will be available. Select the checkpoint you want to use, and specify the corresponding title. After that click "Create" button

![](../assets/legacy/nn/checkpoints/check_new_confirm.png)

Now the model with the specified name is available on the "Neuran networks" page. 

![](../assets/legacy/nn/checkpoints/check_check.png)


You can treat this model exactly the same way as all other available models

{% hint style="info" %}
After the training process is finished, a model that corresponds to the latest checkpoint is automatically added to the "Neural Networks" page 
{% endhint %}

For example, in a case of UNet training, checkpoints #3, #7, #10 are added to "My models" and the segmentation results are visualised

Here is segmentation results of a model from checkpoints #3
![](../assets/legacy/nn/checkpoints/chk_3.png)

Here is segmentation results of a model from checkpoints #7
![](../assets/legacy/nn/checkpoints/chk_7.png)

Here is segmentation results of a model from checkpoints #10
![](../assets/legacy/nn/checkpoints/chk_10.png)

You can see that as training progresses the results are getting better


# Unused checkpoint cleanup

In a lot of cases models might occupy a significant amount of disk space, so it's important to remove the checkpoints that will not be useful in a future.

Checkpoints are associated with a particular training task. In order to remove unused checkpoints, you need to select "Move Unused to Trash Bin" in the context menu of the relevant task.

![](../assets/legacy/nn/checkpoints/check_cleanup.png)






