---
description: >-
    This article describes performance improvements in the 3D Point Cloud labeling tool, including the migration to a WebGPU-based rendering pipeline and optimizations for the Pen and Select tools.
---

# 3D Point Cloud Performance Optimizations

To handle the increasing scale and complexity of modern 3D datasets, the [3D Point Cloud labeling tool](./3D-point-cloud-episodes-2.md) has undergone a series of significant performance improvements. The most impactful change is the migration of the rendering pipeline from **WebGL** to **WebGPU** — a next-generation graphics API that enables substantially better GPU utilization directly in the browser.

As a result, the tool now handles **point clouds of unprecedented scale** without sacrificing responsiveness or annotation quality. Users on everyday hardware can comfortably work with datasets that were previously impractical, while high-end workstations can push into entirely new territory.

## WebGPU Rendering Pipeline

The previous rendering backend, WebGL, was limited in how efficiently it could communicate with modern GPUs. The switch to **WebGPU** lifts those constraints by providing lower-level hardware access, reducing overhead, and enabling more parallelism during rendering.

What this means in practice:

- **More points rendered per frame** — the tool now scales far beyond what was previously possible.
- **Smoother interaction** on low- and mid-tier machines when working with large point clouds.
- **Higher frame rates** on powerful hardware, keeping the annotation experience fluid even at extreme point counts.
- No configuration required — the improvement is automatic for all users running a supported browser.

{% hint style="success" %}
WebGPU is supported in: **Chrome** 113+, **Edge** 113+, **Firefox** 141+ (macOS) / 145+ (Windows), and **Safari** 26+ (macOS Tahoe 26, iOS 26).
{% endhint %}

{% embed url="https://youtu.be/sbo9FbyPza0" %}

## Performance Benchmarks

The table below shows measured frame rates across a range of devices and point cloud sizes, illustrating the real-world impact of the new rendering pipeline.

| Device | Point Count | Frame Rate |
|---|---|---|
| MacBook Air (M-series) | 10,000,000 | ~50 fps |
| MacBook Air (M-series) | 40,000,000 | ~20 fps |
| MacBook Air M4 | 40,000,000 | ~52 fps |
| MacBook M1 Pro | 40,000,000 | ~100 fps |
| MacBook Pro (M4 Pro) | 100,000,000 | 11+ fps |
| NVIDIA RTX 5090 | 100,000,000 | 120+ fps |

{% hint style="info" %}
These results reflect real-world annotation sessions. Actual performance may vary depending on browser version, system load, and scene complexity.
{% endhint %}

The key takeaway: **even entry-level hardware can now work comfortably with 3D point clouds containing tens of millions of points**, while professional-grade machines handle scenes of 100M+ points at full interactive frame rates.


## Tool Optimizations

Alongside the rendering pipeline upgrade, two core annotation tools have been optimized specifically for large-scale point clouds.

### Pen Tool

The **Point Cloud Pen** tool has been re-engineered to remain precise and responsive even when working with extremely dense scenes. Point selection, brush strokes, and fill operations now perform efficiently regardless of the total number of points in the scene.

<figure><img src="../../.gitbook/assets/3d-pc-optimizations/pen-tool-large-cloud.jpg" alt=""><figcaption>Pen tool working with a large-scale point cloud</figcaption></figure>

### Select Tool

The **Select tool** has been updated to handle high point counts without lag when clicking, lassoing, or interacting with annotated objects. Selections that previously caused noticeable delays on dense clouds now respond instantly.

<figure><img src="../../.gitbook/assets/3d-pc-optimizations/select-tool-large-cloud.jpg" alt=""><figcaption>Select tool on a dense point cloud scene</figcaption></figure>

## Summary

The performance improvements introduced in `v6.15.57` update make the 3D Point Cloud tool significantly more capable:

- **WebGPU rendering** unlocks smooth annotation at scales previously unachievable in the browser.
- **Low-end hardware** can now handle 40M+ point scenes at usable frame rates.
- **High-end hardware** reaches 100M+ points at 100–120+ fps.
- **Pen and Select tools** are optimized to stay fast and accurate regardless of scene density.

These changes are transparent to the user — no settings need to be changed to benefit from the improvements.
