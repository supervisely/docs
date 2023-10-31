# Converting & Splitting data

Converting data into different formats and splitting it into training and testing sets are essential operations in data preparation. In this section, you'll discover tools for efficiently performing these tasks. Additionally, we have specific applications designed for data conversion and splitting, simplifying these processes.

## Example apps:
* [Convert Supervisely to YOLO v5 format.](https://app.supervisely.com/ecosystem/apps/convert-supervisely-to-yolov5-format?id=30) Transform images project in Supervisely (link to format) to YOLO v5 format and prepares downloadable tar archive.
* [Convert Class Shape.](https://app.supervisely.com/ecosystem/apps/convert-class-shape?id=8)
t is often needed to convert labeled objects from one geometry to another while doing computer vision reseach. There are huge number of scenarios , here are some examples:
  * you labeled data with polygons to train semantic segmentation model, and then you decided to try detection model. Therefore you have to convert your labels from polygons to rectangles (bounding boxes)
  * or you applied neural network to images and it produced pre-annotations as bitmaps (masks). Then you want to transform them to polygons for manual correction.
 * [Convert Point Clouds project to Episodes.](https://app.supervisely.com/ecosystem/apps/convert_ptc_to_ptc_episodes?id=170) Convert point clouds project to Point Cloud Episodes format. All figures (3D bounding boxes) with the same object_id from different point clouds will be united into tracklets.

    It is a useful app If you have a Point Clouds project and you want to apply 3D tracking tools and export project annotations with tracklets in a convenient-to-use format.

* [Convert labels to rotated bboxes.](https://app.supervisely.com/ecosystem/apps/convert-labels-to-rotated-bboxes?id=206) Convert labels in the project or dataset to rotated bounding boxes (Polygon with properties of rotated bbox). Supported shapes: Polygon, Bitmap, Line, Rectangle or Any Shape with any of the mentioned shapes. Resulting label names will be added suffix ro_bbox, e.g plane -> plane_ro_bbox. Disable Keep original annotations checkbox if you don't want to copy original labels. Application always converts data to the new project, original project will remain unchanged.

* [Convert to semantic segmentation.](https://app.supervisely.com/ecosystem/apps/convert-to-semantic-segmentation?id=209) App converts all supported labels to one bitmap for each supported class. It may be helpful when you change your task from instance to semantic segmentation.

  * Supported classes: Polygon, Bitmap or Any Shape

  * Supported labels: Polygon, Bitmap

    All other shapes will be ignored, and will not be presenting in resulted project.
