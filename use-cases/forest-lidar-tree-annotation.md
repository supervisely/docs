---
keywords:
  - forest lidar annotation
  - tree detection point cloud
  - uav lidar labeling
  - 3d cuboid annotation
  - ai point cloud labeling
  - individual tree segmentation
  - las point cloud labeling
  - forestry 3d annotation
  - FOR-instance dataset
description: >-
  Open a UAV LiDAR forest plot in Supervisely, fit a 3D cuboid to each tree with
  AI Smart Lasso, mask a tree by hand and check its height.
---

# Label Trees in Forest LiDAR with AI 3D Cuboids

## What you will do

You open a UAV LiDAR scan of a forest plot in the 3D point cloud labeling tool and look around the stand. Then you label trees: the AI fits a 3D cuboid to a whole tree, from the ground to the treetop, after you circle its crown once, with **Zoom to object** off so the views stay put. Then you label one tree point by point with the Point Cloud Pen: you outline its crown in a big Top view and cut out the ground in a big Side view. Last, you measure that tree's height with the ruler.

The plot has 1.8 million points, about 28 × 32 m, with trees up to about 29 m tall.

## Before you start

* A Supervisely account and a point cloud project.
* The data: one plot from **FOR-instance** (Puliti et al. 2023), a benchmark of UAV laser scans with hand-segmented trees. Download it from [Zenodo](https://zenodo.org/records/8287792); the paper is on [arXiv](https://arxiv.org/abs/2309.01279). The dataset is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). This page uses the CULS plot 1 (a Riegl UAV scan from the Czech Republic).
* Two classes in the project:
  * `tree` with the **Cuboid** shape, for the AI fit;
  * `tree_points` with the **Point Cloud** shape, for masks drawn by hand.
* The [3D AI assistant](https://ecosystem.supervisely.com/apps/3d-ai-assistant) app running on a GPU agent in your team. Without it, Smart Lasso says **AI Engine is not running**.
* A browser with WebGPU, for example Chrome or Edge 113 or newer. The tool renders dense clouds with WebGPU: see [Performance Upgrade for Dense Clouds](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/3D-point-cloud-optimizations.md).

## Bring a forest plot into Supervisely

The import reads `.las`, `.laz`, `.ply` and `.pcd` files: see [.PCD, .PLY, .LAS, .LAZ pointclouds](../data-organization/import/import/supported-formats-pointcloud/point_clouds.md).

FOR-instance plots are stored in large map (UTM) coordinates. For this page the plot was recentred, each axis minus its minimum, and saved as PCD, so the view opens on the plot. A file with large coordinates can open off-centre.

The file's `classification` and `treeID` fields are not imported as labels. This page labels the trees from scratch.

## Open the plot

Open the project, then the dataset, and click the point cloud card. The 3D point cloud labeling tool opens with four views: **Top**, **Side**, **Front** and **Perspective**. The counter above the Perspective view shows that all 1,816,672 points are loaded.

<figure><img src="../.gitbook/assets/use-cases/forest-lidar-tree-annotation/open-forest-plot.gif" alt="Opening the FOR-instance forest plot from its dataset in the 3D point cloud labeling tool"><figcaption><p>Opening the plot. Data: FOR-instance, Puliti et al. 2023, CC BY 4.0.</p></figcaption></figure>

## Look around the stand

Click the **Perspective** view to make it active. With the Move tool (`1`, the default):

* left-drag to orbit,
* right-drag to pan,
* the mouse wheel to zoom.

Tilt the view to see the stems and the ground under the canopy, then zoom in on a crown.

Dense crowns are easier to read with larger points. Open the **Settings** tab next to **Definitions** and, under **CLOUD POINTS**, raise **Perspective, points size**. **Color mode** stays on **Z-coord (height)**, so the ground is blue and the crowns are red. Go back to the **Definitions** tab.

<figure><img src="../.gitbook/assets/use-cases/forest-lidar-tree-annotation/explore-forest-plot.gif" alt="Orbiting, zooming and panning the forest plot, then raising the Perspective points size in Settings"><figcaption><p>Looking around the stand and raising the points size (1.5× speed).</p></figcaption></figure>

## Fit a tree with AI

By default the tool moves the camera to every new or selected object. While you fit tree after tree, that jump gets in the way, so turn it off first:

1. Open the **Settings** tab next to **Definitions**, scroll to **USER INTERFACE** and turn off **Zoom to object**. Go back to the **Definitions** tab. The tool keeps this setting in your browser.
2. In the **Definitions** panel, click the class `tree`.
3. Open the arrow next to **Smart 3D Lasso** in the top bar and choose **Smart Lasso 3D Object Detection**.
4. In the **Top** view, press and drag a circle around one crown and release.

About 5 seconds later a cuboid appears and `tree` shows in the **Objects** list. The views stay where they were. The cuboid spans the whole tree, from the ground to the treetop: the Side view shows it as 26.33 m high and 7.36 × 6.38 m wide.

<figure><img src="../.gitbook/assets/use-cases/forest-lidar-tree-annotation/ai-fit-tree.gif" alt="Turning off Zoom to object in Settings, then circling a crown in the Top view with Smart Lasso 3D Object Detection; a cuboid 26.33 m high appears around the whole tree"><figcaption><p>Zoom to object off, then one circle around the crown gives a cuboid for the whole tree.</p></figcaption></figure>

## Fit the next trees

Press `Space` before each new circle to start a new object. If a cuboid is still selected, a circle re-fits that cuboid instead of adding a new one.

Circle the next crowns the same way. With **Zoom to object** off, the views stay put while the AI fits tree after tree. On this plot the next fits were 25.67 m and 25.44 m high. Where crowns touch, the box stops where they meet: the fourth tree, whose crown touches its neighbour, got a 23.99 m cuboid that does not reach into the neighbour.

<figure><img src="../.gitbook/assets/use-cases/forest-lidar-tree-annotation/ai-fit-more-trees.gif" alt="Pressing Space and circling three more crowns while the views stay put; four tree objects in the Objects list"><figcaption><p>Space, circle, repeat: four trees labeled, and the views do not move.</p></figcaption></figure>

## See the camera move to a new tree

To see what the setting does, turn **Zoom to object** back on and fit one more tree. When the cuboid appears, the **Perspective** view moves to it and the **Side** and **Front** views re-centre and zoom out on it. That is handy when you check one object at a time. For many fits in a row, keep it off.

<figure><img src="../.gitbook/assets/use-cases/forest-lidar-tree-annotation/zoom-to-object-on.gif" alt="Turning on Zoom to object in Settings and circling one more crown; the Perspective, Side and Front views move to the new cuboid"><figcaption><p>Zoom to object on: the views move to the new tree.</p></figcaption></figure>

## Mask a tree by hand

A cuboid is a box around the tree. For the tree's own points, draw a mask with the **Point Cloud Pen**. Start with an empty scene, so the mask does not mix with a cuboid: the trash button in the **Objects** panel removes all objects (it asks to confirm). Turn **Zoom to object** off again, so the views stay put when the new mask is selected.

**Tip: resize the views.** The Top, Side, Front and Perspective views sit in a layout you can change. Drag the border between two views to make one of them bigger. A big view makes each click precise, and switching to another projection is just one more drag. The tool remembers the layout in your browser.

1. **Make the Top view big.** Drag the border under the **Side** view down, then the border under the **Top** view down, then the border between the Top view and the **Perspective** view to the right.
2. **Zoom in on one tree.** With the Move tool (`1`), drag a single standing tree to the middle of the Top view and zoom in with the mouse wheel. The wheel zooms on the middle of the view, so move the tree there first.
3. Click the class `tree_points` in the **Definitions** panel and press `5` for the **Point Cloud Pen**.
4. **Outline the crown.** In the **Top** view, click around the whole crown, a little outside its edge, then click the first point to close the outline. The mask is saved and shows in orange. Points outside the outline stay unlabeled, so leave a margin around side branches. An outline from above takes every point under it, the ground included.
5. **Make the Side view big.** Drag the border under the Top view up: now the **Side** view fills the column.
6. **Cut the ground.** In the Side view, right-drag the tree's base to the middle and zoom in close on the ground band. Hold `Shift` and click an outline around the ground band, then its first point again. Keep the outline's top edge at the top of the ground band, and step it down around the stem so it stops where the stem starts. The ground leaves the mask, and the stem keeps its foot.

Under a tree the ground and the foot of the stem overlap in height: here the stem starts at about 1.0 m and the ground points reach 1.2 m, so a straight cut across the band either leaves ground in the mask or cuts off the foot of the stem. The step around the stem keeps the whole stem and leaves only a few ground points next to it.

Zoom out in the Side view: the orange mask is the tree, from the foot of the stem to the top, without the ground.

<figure><img src="../.gitbook/assets/use-cases/forest-lidar-tree-annotation/mask-tree-by-hand.gif" alt="Dragging the layout borders to make the Top view big, outlining a single tree's whole crown with a margin using the Point Cloud Pen, then making the Side view big, zooming in close and subtracting the ground with a Shift outline that steps down around the stem"><figcaption><p>Big Top view for the outline, big Side view for the ground cut (1.75× speed).</p></figcaption></figure>

## Check the tree's height

Measure the tree you just masked, with nothing else in the scene, so the ruler's labels do not overlap other objects.

1. **Make the Side view big**, the same way: drag the border under the Side view down, the border under the Top view up, and the border next to the Perspective view to the right.
2. Drag the orange tree to the middle and zoom in until you see its whole height.
3. Press `6` for **Measure Distance**. Click the foot of the stem, then the top of the tree.

Each marker shows its X, Y, Z, and the panel in the corner shows the ruler's length. Read the height from Z: the top Z minus the base Z. Here the markers read Z 1.016 and 27.136, so the tree is about 26.1 m tall from the foot of the stem. The ruler says 26.369 m because it is the 3D distance between the two points, and this stem leans.

A view shows every point along the line of sight, and the ruler takes a point under the cursor. Measure in the view where nothing taller stands in front of or behind the treetop. On this tree the Front view put the top click on a tree about 15 m further back; the Side view did not.

Press `Esc` to clear the ruler (it is not saved as a label) and `Esc` again to leave the tool.

<figure><img src="../.gitbook/assets/use-cases/forest-lidar-tree-annotation/check-tree-heights.gif" alt="Making the Side view big, then measuring the masked tree from the foot of the stem to its top with Measure Distance; the markers read Z 1.016 and 27.136"><figcaption><p>Top Z minus base Z: about 26.1 m (1.5× speed).</p></figcaption></figure>

## What this workflow does not do

* The points are not coloured by the file's `classification` or `treeID`.
* The dataset's hand-segmented trees are not imported as labels.
* Smart Lasso gives a cuboid, not a point mask. There is no cuboid-to-mask conversion, so masks are drawn with the Pen.
* Where crowns touch, the AI box stops where they meet: check those trees by hand.

## Next steps

* Split plots among a team with [Labeling Jobs](../labeling/jobs/README.md).
* [Export](../data-organization/import/export/export.md) the labels in Supervisely format to train a tree detection or segmentation model.
* Label the ground with **Ground Segmentation** from the same AI menu: see [3D Point Cloud Ground Segmentation](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/README.md#3d-point-cloud-ground-segmentation).

## Read next

* [3D Point Cloud and Episodes](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/README.md): [Point Cloud Pen](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/README.md#3d-point-cloud-pen), [Measure Distance](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/README.md#measure-distance), [Hotkeys](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/README.md#hotkeys)
* [Labeling with AI: 3D Point Clouds](../labeling/labeling-with-AI/3d-point-clouds/README.md)
* [Performance Upgrade for Dense Clouds](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/3D-point-cloud-optimizations.md)
* [.PCD, .PLY, .LAS, .LAZ pointclouds](../data-organization/import/import/supported-formats-pointcloud/point_clouds.md)
* [Geospatial overview](geospatial.md)
