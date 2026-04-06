---
description: >-
  This article describes performance improvements in the 3D Point Cloud labeling
  tool, including the migration to a WebGPU-based rendering pipeline and
  optimizations for the Pen and Select tools.
---

# 3D Point Cloud Performance Upgrade: Faster Rendering for Massive Datasets

To handle the increasing scale and complexity of modern 3D datasets, the [3D Point Cloud labeling tool](./) has undergone a series of significant performance improvements. The most impactful change is the migration of the rendering pipeline from **WebGL** to **WebGPU** — a next-generation graphics API that enables substantially better GPU utilization directly in the browser.

As a result, the tool now handles **point clouds of unprecedented scale** without sacrificing responsiveness or annotation quality. Users on everyday hardware can comfortably work with datasets that were previously impractical, while high-end workstations can push into entirely new territory.

{% embed url="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F9mM1dNm0uHlRsfWgJmow%2Fuploads%2FteQmm0BXOeQlFIgUcpa5%2Fpcde-tool-performance.mp4?alt=media&token=198f6ef1-d93e-40bf-8a1b-f9173adc8a67&loop=1&autoplay=1" %}
Smoothly exploring point cloud scene without frame rate drops.
{% endembed %}

## WebGPU Rendering Pipeline

The previous rendering backend, WebGL, was limited in how efficiently it could communicate with modern GPUs. The switch to **WebGPU** lifts those constraints by providing lower-level hardware access, reducing overhead, and enabling more parallelism during rendering.

What this means in practice:

* **More points rendered per frame** — the tool now scales far beyond what was previously possible.
* **Smoother interaction** on low- and mid-tier machines when working with large point clouds.
* **Higher frame rates** on powerful hardware, keeping the annotation experience fluid even at extreme point counts.
* No configuration required — the improvement is automatic for all users running a supported browser.

Additionally, the new pipeline drastically improves overall scene scalability. Previously, interface performance would noticeably degrade after annotating just 20 to 40 objects. The main workspace can now comfortably handle up to 1,000 annotated objects in a single scene, ensuring that complex, large-scale labeling tasks remain completely fluid.

For teams in autonomous driving, robotics, and geospatial mapping, these scalability upgrades are transformative. Production pipelines in these fields routinely generate dense LiDAR scenes filled with hundreds of vehicles, pedestrians, and structural elements. The ability to smoothly render 100M points and handle up to 1000 objects simultaneously means annotators no longer need to downsample critical data or split environments into artificially small chunks. They can work with full spatial context and maximum precision, exactly as the sensors captured it.

### Rich Visualizations with Zero Overhead

When working with complex scans, adjusting the visual representation is often necessary to spot fine details or distinguish overlapping objects. The labeling interface provides a comprehensive Settings Panel for customizing how point clouds are displayed:

* **Dynamic Color Modes:** Instantly switch between true-color **RGB**, elevation-based heatmaps (**Z-coord**), distance from the center, or camera device colors.
* **Intensity Adjustments:** Toggle **Intensity** mapping on or off and tweak the multiplier to highlight highly reflective surfaces—a critical feature for precise LiDAR analysis.
* **Instant Object Recoloring:** Randomize the colors of annotated objects and bounding boxes on the fly to improve contrast and scene readability.

Crucially, because all rendering calculations now run directly on the GPU via the new pipeline, applying these visual filters has **no impact on performance**. You can switch color palettes, adjust point sizes, and recolor thousands of objects instantaneously, keeping your frame rates buttery smooth even on 100M point scenes.

{% hint style="success" %}
WebGPU is supported in: **Chrome** 113+, **Edge** 113+, **Firefox** 141+ (macOS) / 145+ (Windows), and **Safari** 26+ (macOS Tahoe 26, iOS 26).
{% endhint %}

{% embed url="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F9mM1dNm0uHlRsfWgJmow%2Fuploads%2F3BkyDBEzBdzGLspT43Bz%2Foverall-performance.mp4?alt=media&token=8b1a0edd-fc05-4682-b1b4-c342d486c13d&loop=1&autoplay=1" %}
Even dense point clouds with over 62 million points render smoothly and remain fully interactive.
{% endembed %}

## Performance Benchmarks

The table below shows measured frame rates across a range of devices and point cloud sizes, illustrating the real-world impact of the new rendering pipeline.

| Device                 | Point Count | Frame Rate |
| ---------------------- | ----------- | ---------- |
| MacBook Air (M-series) | 10,000,000  | \~50 fps   |
| MacBook Air (M-series) | 40,000,000  | \~20 fps   |
| MacBook Air M4         | 40,000,000  | \~52 fps   |
| MacBook M1 Pro         | 40,000,000  | \~100 fps  |
| MacBook Pro (M4 Pro)   | 100,000,000 | 115+ fps   |
| NVIDIA RTX 5090        | 100,000,000 | 120+ fps   |

{% hint style="info" %}
These results reflect real-world annotation sessions. Actual performance may vary depending on browser version, system load, and scene complexity.
{% endhint %}

Historically, macOS devices (particularly MacBooks) experienced significantly lower performance when dealing with point clouds compared to systems equipped with dedicated RTX graphics cards. The new WebGPU pipeline completely changes this dynamic. Even older, entry-level Apple Silicon laptops (like the base M1) now deliver excellent results, providing a perfectly comfortable workflow. On the other end of the spectrum, powerful systems like the M4 Pro deliver astronomical performance, standing toe-to-toe with high-end GPUs like the RTX 5090.

**The key takeaway**: whether you're using an entry-level laptop or a professional-grade workstation, you can now comfortably work with scenes containing tens to hundreds of millions of points at full interactive frame rates.

## Tool Optimizations

Alongside the rendering pipeline upgrade, two core annotation tools have been optimized specifically for large-scale point clouds.

### Pen Tool

The **Point Cloud Pen** tool has been re-engineered to remain precise and responsive even when working with extremely dense scenes. Point selection, brush strokes, and fill operations now perform efficiently regardless of the total number of points in the scene.

{% embed url="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F9mM1dNm0uHlRsfWgJmow%2Fuploads%2FnjwNrsFjTO0t95J27lYy%2Fpen-tool.mp4?alt=media&token=dec46f49-4eab-4066-a3dc-2221512589f7&loop=1&autoplay=1" %}
Smoothly annotating a tree in a highly dense urban scene.
{% endembed %}

### Select Tool

The **Select tool** has been updated to handle high point counts without lag when interacting with annotated objects. Selections that previously caused noticeable delays on dense clouds now respond instantly.

{% embed url="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F9mM1dNm0uHlRsfWgJmow%2Fuploads%2FXK5r5CxKFbFOvMG1U8TX%2Fselect-tool.mp4?alt=media&token=cae6b500-d2d6-424c-9dd2-85d2b6d015e7&loop=1&autoplay=1" %}
Instant object selection and seamless interaction
{% endembed %}

## Summary

The performance improvements introduced in `v6.15.57` update make the 3D Point Cloud tool significantly more capable:

* **WebGPU rendering** unlocks smooth annotation at scales previously unachievable in the browser.
* **Low-end hardware** can now handle 40M+ point scenes at usable frame rates.
* **High-end hardware** reaches 100M+ points at 100–120+ fps.
* **Massive object scalability** allows for up to 1,000 annotated objects in a single scene without performance degradation.
* **Zero-overhead visual adjustments** enable instant switching between RGB, Intensity, and custom color modes without dropping frames.
* **Pen and Select tools** are optimized to stay fast and accurate regardless of scene density.

These changes are transparent to the user — no settings need to be changed to benefit from the improvements.