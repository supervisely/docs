---
description: "Learn how to accelerate bounding box annotation for automotive bolt detection using Supervisely's Live Training and Out of Center tool for circular objects."
keywords:
  [
    "bounding box annotation",
    "bolt detection",
    "automotive quality control",
    "manufacturing inspection",
    "live training",
    "active learning",
    "object detection",
    "supervisely",
    "industrial computer vision",
    "defect detection",
  ]
---

# Bounding Box Annotation of Wheel Bolts for Automotive QA: Live Training in Supervisely

## Automated Quality Control for Automotive Manufacturing Teams

**The scenario:** An automotive assembly plant produces 2,000 wheels per day. Each wheel has 5 bolts that must be properly installed before the wheel moves to the next production stage. Quality control inspectors stand at checkpoints along the conveyor belt, visually verifying that all bolts are present and correctly positioned on every passing wheel.

**The problem:** Human inspection is slow (15-20 seconds per wheel), inconsistent (fatigue after hours of repetitive checking), and creates bottlenecks that slow down the entire production line. A single missed bolt can lead to safety recalls costing millions, while false positives stop the line unnecessarily and hurt efficiency metrics.

**The solution approach:** The plant deploys computer vision cameras above the conveyor belt to automatically photograph each wheel and detect bolt presence in real-time. But first, they need to train the detection model - and that requires thousands of labeled images showing wheels with correctly annotated bolt positions.

**This is where our workflow helps:** For ML engineers, QA specialists, and data scientists building these object detection systems, creating training datasets for circular objects like bolt heads is uniquely challenging. This guide shows how Supervisely's Live Training and "Out of Center" tools reduce annotation time by 70% while improving consistency, getting your automated inspection system into production faster.

## Computer Vision in Automotive Manufacturing: Research Evidence

Recent research demonstrates the effectiveness of computer vision systems in automotive manufacturing quality control:

- [A Deep Learning-Based Computer Vision System for Automated Screw Detection in Vehicle Wheel Boxes](https://link.springer.com/chapter/10.1007/978-3-031-96997-3_1) (Sakuma et al., Springer 2025) presents a computer vision system specifically designed to replace manual visual inspection of screws in automotive wheel assemblies, demonstrating the critical role of automated inspection.

These studies collectively demonstrate that computer vision systems significantly reduce inspection time, improve consistency, and enable real-time quality control—but all require substantial annotated training datasets to achieve production-ready performance.

## Demonstration Dataset: Automotive Wheel Bolts

To solve the automated quality control challenge described above—deploying computer vision for real-time bolt detection on the assembly line—we first need to create a training dataset. We use 18 front-view images of automotive wheels with 3-10 bolts per wheel to demonstrate how Live Training dramatically accelerates this dataset creation process. All bolts are labeled with a single class "bolt" using the "Out of center" bounding box mode, which is specifically designed for annotating circular objects like bolt heads.
