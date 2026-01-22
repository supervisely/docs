Here are some advices and limitations you need to consider when uploading videos to Supervisely.

## Format support

We strongly recommend upload videos in native browser formats: `.mp4` file container and one of the following codecs: `h264, vp8, vp9`. This way your video will be streamed in web browser without any additional transformation.

You can upload videos in other formats (.avi, .mkv, .mov, etc), but it will be live-transcoded to .mp4 on-fly, which can be slow. If that's the only case for you, please experiment and find the best resolution yourself.

## Size limitation

There is no real limitation on the file size. By default every upload is limited `64GB`, but it can be easily configured in the instance settings.

## Length limitation

There is no real limitation on the video length, but the longer your video, the longer it would take to import your file. This happens because when you upload video file the first time, Supervisely calculates mapping between frame numbers and frame timestamps - thus, the more frames video has, the more work we need to do during import.

## Resolution limitation

While there is no explicit video resolution limit, there are several things you need to consider:

- Your end-user computer performance
- Your network bandwidth

We recommend `FullHD (1920×1080)` if your PC supports hardware acceleration and `HD (1280×720)` if your PC doesn't have any GPU (even Intel HD) or your network bandwidth is limited.
