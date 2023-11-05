# Augmentations
Data augmentation is a crucial step in preparing data for machine learning. In this section, you'll find tools for augmenting your data, allowing you to increase its diversity and enhance machine learning model performance. A specialized data augmentation application streamlines this process and broadens your capabilities.

## Example apps:
* [ImgAug Studio.](https://app.supervisely.com/ecosystem/apps/imgaug-studio?id=70) ImgAug Studio is a wrapper around great ImgAug Library. Interactive UI helps to understand how image transformations work and illustrates how to use this library with Supervisely Format.
Once augmentations are combined into pipeline, they can be exported to both python file (for developers) and safer serialization format json. This json config can be used for real-time augmentations during training for some Neural Networks from Supervisely Ecosystem.
Only labels of types Polygon, Rectangle and Bitmap in supervisely format can be converted automatically to imgaug format (and vice versa).
* [Create Trainset for SmartTool.](https://app.supervisely.com/ecosystem/apps/create-trainset-for-smarttool?id=19)
This app created training dataset for SmartTool from labeled project. All classes in the input project have to be Bitmaps. Please, use app Rasterize objects on images to raster all objects and prepare correct object masks. It is crucial for this app.
All classes will be converted to a single class, then instances crop will be performed and then positive/negative points will be randomly generated.