# Changelog

## 04 August 2020

**Improvements:**
- Added an option to change 'next/previous 10 frames' to an adjustable number of frames in the Video Annotator
- Added API call to extract specific checkpoint
- Added an option to keep the assigned images when cloning Jobs
- Added model identificator to the Neural Networks list
- Added filters to the user list on Labeling Job creation page
- Updated Moving Cursor Time in statistics 
- Added an option to select multiple tags for the frame range in the Video Editor

**Bug fixes:**
- Fixed scroll to the Job in the Labeling Job list
- Fixed email editing
- Multiple bug fixes

## 17 July 2020

**Improvements:**
- Moved pagination to the backend for Labeling Jobs
- Added an option to create Labeling Exams without selecting Classes (Now it's possible to create one with just the Tags selected)
- Added online/offline indicators to the Users page
- Added erase underlying objects" for crop / fill in bitmap tool

**Bug fixes:**
- Fixed filtering objects by tag
- Fixed slowdown for polygons with a large number of points
- Fixed issues with 3D Point Cloud Pen tool selection
- Fixed issues with large remote images
- Fixed the 'The following images with hashes were not found' DTL error

## 22 June 2020

**Improvements:**
- 🤩 HUGE! A new project option "multiple tags mode" which allows you to assign a single tag multiple times. A must have when it comes to a labeling consensus
- ... and of course a new option "Labeler sees tags" so now you can hide tags made by other labelers to remove labeling bias
- New hotkeys: quickly switch between brush / fill tool options
- Custom meta properties for images: attach custom IDs to match two DBs or 100Mb matrices for future inference
- Reset settings button for the image labeling tool (handy for resetting brightness / contrast and opacity)
- Quick *one of* tag value selection: now you can just select a tag, press "3" to select third value and press "enter" to confirm
- Now we show a name of the last labeling job in which dataset was participated to know what dataset is yet to be labeled
- Better handling of laaaaaaaaaaaaaaarge project and dataset names in the table view
- API: Archive / unarchive labeling jobs
- API: Retain `createdAt` and `updatedAt` fields in tags and figures in the `annotations.bulk.add` method

**Bug fixes:**
- Keypoints removal fixed
- Cuboids creation improved
- Maintain case sensitivity in the Links plugin
 
## 28 May 2020

**Improvements:**
- Added real-time project meta update to the annotation interface: now you don't need to manually refresh the page to sync up with other people working on your project
- Added labeler name to the member activity page
- Added *split images randomly / by name* dropdown menu for Labeling Jobs
- Added *by labeler* to the annotation interface filter
- Added activity_logs.attach/detach/update_tag for tags to the API

**Bug fixes:**
- Fixed stats refresh after deleting objects
- Fixed word-warp for titles to the projects list
- Fixed the wrong error description for Labeling Jobs

## 18 May 2020

**Improvements:**
- You can now copy tags from the previous image
- Added list view for projects and datasets
- Added an option to send notifications on endpoints via HTTP requests

**Bug fixes:**
- Fixed bug with tags dissapearing upong cloning a Labeling Job
- Fixed the list of available plugins for adding data to an existing project
- Fixed bug with rolling back changes in the Annotation interface
- Fixed activity log for team memebers

## 20 April 2020

**Improvements:**

- You can now add .pcd and .mp4 to an existing project
- Get Activity Log from Member's content menu
- Change threshold after Exams has already started
- Automatically login user to correct team when opening link to a project  
- `AnnotationInfo` now has `labelerLogin` and `createdAt` fields
- Add pagination to .pcd files list
 
**Bug fixes:**
 
- Fix missing tags settings during labeling jobs cloning
- Fix problem when attaching tag on image that already has that tag  
- Fix bug in `jobs.stats`
- Fix problem when coping porject into an empty workspace
- Fix bug with project class restoring
