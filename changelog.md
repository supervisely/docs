# Changelog

## 18 May 2020

**Improvements:**
- You can now copy tags from the previous image
- Added list view for projects and datasets
- Added an option to send HTTP requests to notifications


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
