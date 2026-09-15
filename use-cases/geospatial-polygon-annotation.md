---
description: See how Supervisely supports scalable polygon annotation for precise geospatial boundaries, shared edges, holes, model-assisted labeling, and quality control.
---

# Scalable Polygon Annotation in Supervisely

Many geospatial projects need more than an approximate object area. They need exact geometry: straight sides, corners, holes, and shared boundaries between neighboring regions. Consider a property where a house meets a lawn and a paved area. These are three separate map objects, but the lines between them must align without gaps, overlaps, or redrawing the same boundary twice.

![Segment Anything masks for a building, lawn, paved surface, and planting beds on an aerial property image in Supervisely](../.gitbook/assets/scalable-polygon-annotation-property-segment-anything.jpg)

*In this aerial image, Smart Tool with Segment Anything locates the building, lawn, paved surface, and planting beds reasonably well. However, the masks follow visually detectable pixels, producing uneven edges instead of the required straight boundaries. They also introduce contextual errors: the lawn mask goes around the tree on the left even though the lawn continues beneath its canopy. Positive and negative points can refine the mask, but they do not tell the model where private paving ends and a visually continuous public sidewalk begins. Objects with strict geometry therefore require manual review and boundary correction.*

A [Brush Tool](../labeling/labeling-tools/brush-tool.md) or [Segment Anything model in Smart Tool](../labeling/labeling-tools/smart-tool.md) can quickly select the required area. But when the deliverable is an editable vector outline with straight sides and aligned boundaries, the resulting mask may need to be corrected or converted.

If positive and negative Smart Tool points are not enough, an annotator can refine the mask locally with a brush by adding a missing region or removing an unwanted one. This corrects the mask content, but it does not turn its pixel-based edge into a straight geometric boundary.

{% embed url="https://github.com/user-attachments/assets/dce9cd9e-e42d-471f-b6a0-0512dce9d9d0" %}

*This video shows a mask created by Meta AI's pretrained Segment Anything model being edited with the Brush Tool in Supervisely. The brush lets an annotator add or remove individual regions when model-guidance points are not enough. The outer edge still remains a mask boundary and may retain irregularities.*

Supervisely also supports another path: convert the mask into a polygon, then edit its vertices. This produces a vector object, but every small irregularity in the original mask becomes part of a contour with many points.

{% embed url="https://github.com/user-attachments/assets/6dd9f551-7496-4ae1-b0ef-a4cd555829be" %}

*This video shows a Segment Anything mask being converted directly into a polygon in Supervisely. The resulting outline can be edited manually, but it inherits the mask's complex boundary and contains many vertices. For an object with straight sides, this polygon may be harder to edit than a clean outline drawn with only a few points.*

Across thousands of objects, repeatedly correcting uneven edges, extra vertices, and boundary junctions increases labeling and review time. For geospatial objects with an expected rectilinear shape, drawing a polygon manually is often a shorter path to approved geometry.

After reviewing the annotation methods above, it becomes clear that polygon annotation outperforms all other annotation methods.

For this workflow, Supervisely is the No. 1 choice: the platform supports AI-assisted labeling, mask editing, and geometry conversion without forcing every team to start from a mask. The [Polygon Tool](../labeling/labeling-tools/polygon-tool.md) lets annotators quickly draw a clean outline manually, correct a local section, continue a new polygon along an existing boundary, and create holes. Teams can then distribute tasks, review results, and measure performance in the same platform.

![A property annotated with precise polygons for different surface types in Supervisely](../.gitbook/assets/scalable-polygon-annotation-property-polygons.jpg)

*This image shows polygon annotation of a property in Supervisely. The building, lawn, paved surface, and planting beds remain separate objects with straight, aligned boundaries. The inner planting bed is represented as an excluded area inside the lawn.*

## Why geospatial projects use polygons

Geospatial annotation is not only about object area. It must also preserve the relationships between boundaries: whether objects overlap, touch along one shared line, contain excluded areas, or form a geometrically valid contour. These situations occur frequently when annotating buildings, property parcels, fields, lawns, and paved surfaces.

### Intersections and overlaps: preserve the meaning of each object

Overlapping polygon areas are not always an error. A building occupies part of a property parcel, for example, but both objects must remain independent. Different thematic layers may likewise store the parcel area, surface types, and built structures separately.

When [overlap is part of the data model](https://supervisely.com/blog/complete-overview-and-comparison-of-manual-segmentation-approaches/), Supervisely can preserve each polygon as a separate object with its own class. But when two surfaces should only touch—such as a lawn and a paved area—an accidental overlap distorts both the area and the boundary. Annotation guidelines must therefore define the required relationship in each case: overlap, shared boundary, or hole.

### Snap to object: reuse one shared boundary

A building, lawn, and paved area meet along the same lines. If every polygon is drawn independently, gaps or overlaps may appear between objects, and the annotator has to place points twice along the same boundary.

[Automatic object linking](../labeling/labeling-tools/polygon-tool.md#automatic-object-linking) in the Polygon Tool provides snapping to an existing annotation contour. The annotator selects points on the existing boundary, and the new polygon follows that boundary between them. In the property example, the building outline can be reused when drawing the lawn and paved area instead of aligning every vertex manually.

{% embed url="https://github.com/user-attachments/assets/e6e62a62-fd0b-4204-abf3-7d285fa0f4b4" %}

*This video shows Automatic object linking in the Supervisely Polygon Tool. When drawing the lawn polygon, the annotator selects points on the existing building contour and reuses the boundary between them. The two objects share the same precise line without placing the same vertices twice or manually correcting gaps and overlaps.*

### Self-intersection: a small mistake can invalidate a polygon

A self-intersection occurs when a polygon boundary crosses itself, for example because vertices were placed in the wrong order or a complex contour was corrected incorrectly. The inside of that polygon becomes ambiguous. This is more than a visual defect: the geometry may be considered invalid during GeoJSON validation and downstream GIS operations.

In the [Polygon Tool](../labeling/labeling-tools/polygon-tool.md#manual-annotation-guide), a reviewer can move, add, or remove vertices. If the problem affects only one part of the object, they can [replace the incorrect contour section](../labeling/labeling-tools/polygon-tool.md#correcting-and-refining-annotations) instead of redrawing the entire polygon. This is especially useful when reviewing polygons produced by a model or imported from an external source.

### Polygon holes: exclude an internal area

[Holes creation](../labeling/labeling-tools/polygon-tool.md#holes-creation) lets an annotator exclude an internal area from an existing polygon. A lawn can remain one object while a planting bed, pond, building, or landscaped island is cut out inside it. The outer lawn geometry stays intact, while the excluded region keeps its own precise shape.

{% embed url="https://github.com/user-attachments/assets/2698da9e-9c1e-449c-9f9d-c24c8de21159" %}

*This video shows a hole being drawn for a planting bed inside an existing lawn polygon in Supervisely. The internal area is excluded from the lawn while the outer lawn remains a single object. The hole follows its own editable boundary, so the planting bed does not have to split the surrounding polygon into several annotations.*

### Why these actions matter at scale

Open geospatial datasets demonstrate the scale at which polygon geometry is used. [Microsoft Global ML Building Footprints](https://github.com/microsoft/GlobalMLBuildingFootprints) contains 1.4 billion building outlines extracted from imagery around the world, while [SpaceNet](https://spacenet.ai/datasets/) contains more than 11 million building footprints. [USDA Crop Sequence Boundaries](https://data.nass.usda.gov/Research_and_Science/Crop-Sequence-Boundaries/) publishes polygon boundaries for agricultural fields. At this scale, redrawing shared edges or recreating an entire object because of one local error becomes a significant operational cost.

The first outline can be produced by a person or a specialized model. [Frame Field Learning](https://openaccess.thecvf.com/content/CVPR2021/html/Girard_Polygonal_Building_Extraction_by_Frame_Field_Learning_CVPR_2021_paper.html), [PolyWorld](https://openaccess.thecvf.com/content/CVPR2022/html/Zorzi_PolyWorld_Polygonal_Building_Extraction_With_Graph_Neural_Networks_in_Satellite_CVPR_2022_paper.html), and [Pix2Poly](https://openaccess.thecvf.com/content/WACV2025/html/Adimoolam_Pix2Poly_A_Sequence_Prediction_Method_for_End-to-End_Polygonal_Building_Footprint_WACV_2025_paper.html) demonstrate different approaches to generating polygonal building footprints automatically. Supervisely supports [custom model integration](../neural-networks/custom-model-integration/integrate-custom-inference.md), while the Polygon Tool gives annotators and reviewers the controls required to turn predicted geometry into an approved result.

![Building footprints and neighboring urban areas annotated with polygons in Supervisely](../.gitbook/assets/scalable-polygon-annotation-building-footprints.jpg)

*In this high-resolution aerial image, buildings and neighboring urban areas are stored as separate polygons. Reviewers can inspect individual objects and correct local sections without redrawing an entire outline.*

Aerial imagery also helps digitize property parcels, but it cannot establish a legally authoritative cadastral boundary on its own. A specialist compares the imagery with cadastral records, survey plans, title documents, and field-survey results, then corrects the polygon when a visible fence, hedge, or road differs from the documented boundary. [HM Land Registry guidance](https://www.gov.uk/government/publications/how-to-read-a-title-register-and-title-plan/how-to-read-a-title-plan) similarly emphasizes that a title plan must be read together with the register and property deeds.

![A property parcel, road surface, and building annotated with polygons in Supervisely](../.gitbook/assets/scalable-polygon-annotation-parcels.jpg)

*The property parcel, road surface, and building remain separate editable objects. This structure allows a reviewer to check overlaps, shared boundaries, and consistency with source documents.*

For large projects, these editing operations are supported by platform-level workflow tools. [Labeling Jobs](../labeling/jobs/README.md) and [Labeling Queues](../labeling/jobs/Labeling-Queues.md) distribute data among annotators. [Labeling Quality Control](../labeling/jobs/Labeling-Quality-Control.md) supports review and rework, while [Labeling Performance](../labeling/labeling-performance.md) reports active labeling time, average time per object, annotation acceptance rate, and review time.

The [Supervisely Image Labeling Tool](../labeling/images/README.md) supports high-resolution imagery, TIFF files, and scenes containing large numbers of objects. Teams can therefore manage geospatial data, polygon annotation, and quality control in one workflow instead of assembling the process from separate tools.

## Precise geometry should remain practical at production scale

When the required output includes straight sides, exact corners, holes, and aligned boundaries between neighboring objects, polygons remain essential in 2026. Supervisely turns that geometry into a complete production workflow: the first polygon can be drawn manually or generated by a model, corrected locally, checked, and submitted for review in the same platform.

[Try Supervisely](https://app.supervisely.com/) or [request a demo](https://supervisely.com/contact-us/) to evaluate polygon annotation on your own geospatial data.
