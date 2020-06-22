# Changelog

## 22 June 2020

**Improvements:**
- Reset settings button for the image labeling tool (handy for resetting brightness / contrast and opacity)
- Quick *one of* tag value selection: now you can just select a tag, press "3" to select third value and press "enter" to confirm
- Now we show a name of the last labeling job in which dataset was participated to know what dataset is yet to be labeled
- Better handling of laaaaaaaaaaaaaaarge project and dataset names in the table view
- API: Retain `createdAt` and `updatedAt` fields in tags and figures in the `annotations.bulk.add` method

**Bug fixes:**
- Keypoints removal fixed
- Cuboids creation improved
 
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
