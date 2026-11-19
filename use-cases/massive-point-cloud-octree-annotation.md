---
keywords:
  - large point cloud annotation
  - point cloud octree
  - massive lidar annotation
  - scan to bim annotation
  - building point cloud segmentation
  - area of interest point cloud
  - point cloud pen
  - stadium lidar scan
description: >-
  Annotate building-scale LiDAR scans in Supervisely: isolate one structure
  with an Area of Interest, keep millions of selected points in one
  point_cloud_octree annotation, and convert it when a regular point cloud is
  required downstream.
---

# Annotate Massive Point Clouds with Octree Geometry

## A building scan is geometry without meaning

Before an existing stadium, shopping center or other large building is renovated, engineers need an accurate record of what was actually built. Terrestrial laser scanners, mobile mapping systems and drones can capture the site as a dense point cloud, including structures that may differ from the original drawings.

The scan records where each visible surface is, but not what it represents. It does not distinguish a seating tier from the stairs beside it, a concrete slab from a facade, or a roof support from equipment behind it. Point-level labels add that structure to the raw coordinates.

The business question is therefore not “how do we label a big point cloud?” It is more specific:

> How do we keep a complete structural element as one point-level object when that element contains millions of points and overlaps other structures in the 3D view?

This matters in real renovation projects. At Elland Road Stadium, 5,250 registered scan positions covering the inside and outside of all stands supported a Revit model for future redevelopment ([RIEGL case study](https://www.riegl.com/en-austria/news-insights/article/high-speed-3d-capture-of-elland-road-stadium-with-the-riegl-vz-600i)). At Auburn Arena, an as-built scan of the bowl exposed stair-tread spacing that would not accommodate the designed seating count before the seats arrived ([Autodesk case study](https://images.autodesk.com/adsk/files/robins-morton-customer-story.pdf)). Shopping-center scans are similarly used to document architecture, structures and installations for BIM and asset management ([Hexagon case study](https://multivistaservices.hexagon.com/case-studies/shopping-mall-chain-in-madrid-spain/)).

## What Supervisely covers

Supervisely keeps the workflow in the [3D point cloud editor](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/README.md):

- **One editor for the whole scan.** Perspective, Top, Side and Front views show the same registered scene and let the annotator inspect a component from different directions.
- **A streamed point budget.** Auto or Manual mode controls how many points are resident and drawn for the current view, balancing visible detail against GPU workload.
- **A local working region.** **Area of Interest** places an oriented 3D box around the part of the scene being labeled.
- **Point-level geometry at building scale.** The new `point_cloud_octree` geometry keeps a very large selection as one logical annotation instead of forcing it into arbitrary fragments solely because of its point count.
- **A path to existing pipelines.** An octree annotation can be converted to regular point cloud geometry when a customer's ML, BIM or engineering workflow requires it.
- **Teamwork and delivery.** [Labeling jobs](../labeling/jobs/README.md) split scenes among annotators and reviewers, while [export](../data-organization/import/export/export.md) and the API connect the approved result to downstream systems.

{% hint style="info" %}
`point_cloud_octree` is an annotation geometry type, while Area of Interest is temporary editor context. The area is not an annotation and does not crop or modify the source point cloud.
{% endhint %}

## Set how many streamed points the editor draws

The complete scene in this example contains **2,090,815,411 points**. The editor does not need to place all 2.09 billion points in GPU memory at the same time. It streams the spatial nodes needed for the current camera and draws them within the **Point budget of the streamed cloud**.

The screenshot shows a manual budget of 3.10 million points. At that moment, 3.08 million points are resident and the same 3.08 million are drawn. The red **budget-limited** status means the current view requests more octree nodes than the selected budget permits: 230 of 322 wanted nodes remain unloaded, so additional detail is available but is not drawn at this budget.

<figure><img src="../.gitbook/assets/use-cases/massive-point-cloud-octree/point-budget-manual.png" alt="A building-scale point cloud with 2,090,815,411 total points in the Supervisely editor; the streamed-cloud dialog shows a manual 3.10 million point budget, 3.08 million resident and drawn points, and a warning that detail is limited by the budget"><figcaption><p>A 2.09-billion-point scene with a manual streamed-cloud budget of 3.10 million points.</p></figcaption></figure>

The two modes serve different purposes:

- **Auto** uses GPU timing measurements to adjust the point budget and keep navigation responsive as the view changes.
- **Manual** keeps the selected point budget fixed. The editor continues measuring the GPU workload but does not move the budget automatically.

Raise the manual budget when a boundary needs more visible detail and the workstation has enough GPU capacity. Lower it when orbiting or zooming becomes slow. The maximum and GPU-buffer values shown in the dialog describe the current browser and device; they are not a universal limit for every installation.

For the close inspection below, the manual budget is raised to 10.1 million points. The top bar still reports **budget-limited** because the detailed view requests more data than even this larger budget allows. This status is not an error: it says that the selected budget is full and that more spatial detail could be streamed if the budget were raised again.

<figure><img src="../.gitbook/assets/use-cases/massive-point-cloud-octree/point-budget-10m-detail.png" alt="A close view inside a 2.09-billion-point scene in the Supervisely editor with a manual streamed-cloud point budget of 10.1 million points; the top bar reports 10.1M of 10.1M and budget-limited"><figcaption><p>A close inspection with a 10.1-million-point manual budget; the current view still asks for more detail than the budget allows.</p></figcaption></figure>

{% hint style="info" %}
The point budget controls streaming and display detail. It does not delete points, decimate the source cloud, change the saved `point_cloud_octree` annotation, or reduce the point count delivered downstream.
{% endhint %}

## Choose components that match the downstream task

Name classes after the structures the customer needs, not just the building type. For a stadium renovation, these may be `seating_tier`, `stairs`, `concrete_structure`, `railing`, `column`, `roof_structure`, `equipment` and `noise`; for a shopping center, floor slabs, walls, columns, facades, escalators and parking levels.

Decide before production whether the output is semantic (every point labeled `floor`, `wall` or `column`) or instance-based (each column or slab as a separate object, as Scan-to-BIM often requires), and write it into the guidelines.

## Why one annotation can contain millions of points

A seating tier, floor slab or facade can span a large part of the scan and contain millions of points while remaining one structure. Splitting it into fragments just to fit a size limit adds review work and creates false boundaries between parts. With `point_cloud_octree`, the whole component stays one point-level annotation.

## Isolate the structure with Area of Interest

In a dense building scan, several surfaces can fall on top of one another in a projection. Looking at a seating tier from the side may also show the level above it, columns behind it and part of the roof. Area of Interest narrows the working region to the component being labeled.

Select **Area of Interest** in the left toolbar, then click and drag in the Perspective view to place an oriented box around the target. Move, resize and rotate the box until it contains the component but excludes as much neighboring geometry as possible. The same area appears in the Perspective, Top, Side and Front views.

The area can be disabled or removed when the local operation is finished. It is workspace context for the current session: it is not saved as an object, and editing it is not an annotation change.

### Hide or show the surroundings

The **ON** switch enables or disables the existing Area of Interest without requiring the box to be placed again. **Show surroundings** controls whether points outside the box remain visible:

- switch it **off** to hide outside points and work on the local structure without visual clutter;
- switch it **on** when the surrounding geometry is needed for orientation or for checking where the component meets its neighbors.

This is a visibility setting. Hiding the surroundings does not remove points from the source scene or add them to the annotation.

<figure><img src="../.gitbook/assets/use-cases/massive-point-cloud-octree/area-show-surroundings-off.png" alt="Area of Interest around mechanical equipment in the Supervisely point cloud editor with Show surroundings off; the tooltip states that points outside the box are hidden"><figcaption><p>Show surroundings off: points outside the Area of Interest are hidden to reduce visual clutter.</p></figcaption></figure>

### Keep the area outline visible with another tool

Turn **Show outline** on to leave a thin box around the Area of Interest while another annotation tool is active. The outline is useful when Point Cloud Pen, Lasso or another tool is being used: the annotator can still see the intended working region without returning to the Area of Interest tool.

The outline is only a visual reference and does not become an annotation.

<figure><img src="../.gitbook/assets/use-cases/massive-point-cloud-octree/area-show-outline-on.png" alt="A thin orange Area of Interest outline around mechanical equipment in the Supervisely point cloud editor while another tool is active; the Show outline tooltip is visible"><figcaption><p>Show outline on: a thin box keeps the working region visible while another tool is active.</p></figcaption></figure>

## Select the structure's points

Select the target class and mark the structure with the [Point Cloud Pen](../labeling/3D-Point-Clouds/3D-point-cloud-episodes-2/README.md#3d-point-cloud-pen): single clicks place polygon points along straight edges, and click-and-drag paints over irregular areas. The same tool adds or removes points when the boundary needs correction.

## Keep the result as one octree annotation

Save the completed selection as `point_cloud_octree` geometry.

The geometry type changes how a very large point-level annotation is represented. It does not change its semantic role: the annotation still says that all of these points belong to the same physical component.

<figure><img src="../.gitbook/assets/use-cases/massive-point-cloud-octree/octree-wall-annotation.png" alt="A wall section highlighted in magenta as one point_cloud_octree annotation in the Supervisely point cloud editor; its box measures 4.72 by 2.10 by 0.44 meters in a scene of 2,090,815,411 points"><figcaption><p>One <code>point_cloud_octree</code> annotation holds a 4.72 × 2.10 m wall section in the 2.09-billion-point scene.</p></figcaption></figure>

## Summary

A building-scale scan can contain billions of points, and a single structure in it can contain millions. Supervisely handles both: the streamed point budget keeps the full scene navigable, Area of Interest isolates one structure from its surroundings, and `point_cloud_octree` keeps that structure as one annotation, ready for model training, Scan-to-BIM or comparison with a design.
