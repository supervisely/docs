# Frame-based Tagging

Tagging is a popular task in any kind of labeling, and it is especially important in video labeling. While applying a tag to a specific labeling object or video file can be useful, it becomes a bit tricky when it comes to assigning a tag (often with a value) to a range of frames or multiple ranges. This short guide will help you learn how to do frame-based tagging in Supervisely efficiently.

## Defining a Tag and Finding It in the Labeling Toolbox

First, you need to define one or more tags on the [project definitions](/data-organization/projects/definitions) page. The tag scope should be set to either Global and Frame-based or just Frame-based.

You can find these tags later when you open a labeling tool in the definitions panel under the frame-based tags section. Note that depending on whether you have a labeling object selected or not, you will see tags available and assigned either for the current video file or the selected annotation object.

## Starting a Tag Range

Say you are at a specific frame of a video and want to mark some frames with a tag starting from there. It's easy: just find the desired tag in the Definitions panel and check it.

**Note**: If it is a tag with a value, instead of checking the tag, you can enter a tag value or select it in the dropdown right away.

You will see a popup window asking how to add the tag. Let's see an overview of options:

### Option 1: Select Range

The default way of assigning a tag to a range of frames is "Select Range." This will put a tag on a single frame where you are currently at — but as you move through the video, you will see in the Timeline panel that the tag is marked with a dashed line and always ends at the frame where you currently are. When you click the "Finish" button in the Definitions panel, it will end the tag at the current position. Quite convenient, isn't it?

**Note**: You can just press "Enter" to quickly select the default option.

**Note**: You can start multiple unfinished tags as you move through the video and finish them one by one. This is totally valid!

**Note**: Don't worry about closing your labeling toolbox: those unfinished tags will stay where they are, and other people can finish them later if needed.

### Option 2: From Here to End

Another way is to put a tag from your current position to the very end of the video. If the tag range should end before that, simply scroll to the position where the tag should end and uncheck the tag. You will see a popup window suggesting to clear the tag between the current position and the end of the video, leaving the tag with exactly the required range.

### Other Options

You can also click the "Other..." button to find more ways to put a tag. For example, you might need to apply the tag to exactly 20 frames forward. You can also change the default button behavior here and make "From Here to End" the default option.

