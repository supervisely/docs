# Live Training Use Case: Automated Tomato Phenotyping and Segmentation

## **Introduction**

We demonstrate Live Training on a real-world agricultural segmentation task: extracting phenotypic measurements from tomato fruit cross-sections. Live Training achieves [XX]% time savings compared to interactive segmentation with SAM and [YY]% savings compared to traditional Human-in-the-Loop workflows while reaching equivalent model quality ([X.XX] mIoU). The approach provides useful predictions after just 3-4 labeled images and eliminates the coordination overhead that fragments annotation projects into multi-week cycles with idle time between training phases. This addresses a fundamental challenge in domain-specific computer vision: zero-shot foundation models fail completely on specialized data like plant anatomy, yet traditional training requires substantial annotated datasets before providing any assistance, creating an expensive cold start problem that Live Training solves through continuous learning from the first annotations onward.

## **Use Case Overview**

Plant breeders need quantitative measurements of tomato internal structures to select superior cultivars. They measure pericarp thickness (affects durability), locule count and size (affects moisture and taste), and septum characteristics (affects processing suitability). Traditional measurement involves cutting fruits and using calipers, which is slow and subjective. Automated segmentation using computer vision can process hundreds of samples per day, but requires annotated training data.

This presents a practical problem: creating the training dataset requires exactly the manual annotation work that automation is supposed to eliminate. The task is semantic segmentation of tomato cross-section images, identifying nine anatomical structures: pericarp (outer wall), locules (seed cavities), placenta (connecting tissue), septum (dividing walls), core (central tissue), and several smaller components. Each structure appears as distinct regions in cross-section photographs.

\[Image placeholder: Tomato cross-section with colored segmentation overlay showing all nine classes\]

We use the **Tomatoes Annotated dataset** based on research published in *Frontiers in Plant Science* \[Reference: Quantitative Extraction and Evaluation of Tomato Fruit Phenotypes Based on Image Recognition, 2022\]. The dataset contains cross-sections from multiple cultivars with diverse sizes, shapes, and internal morphologies. Images come from controlled photography but show realistic biological variation. This represents typical conditions in specialized domains: dozens to low hundreds of samples, significant visual variation, and no existing labeled data.

The annotation challenge is that domain experts (plant scientists) must do the labeling because they understand anatomical structures. Their time is expensive and limited. Without model assistance, each image requires 10-15 minutes of careful polygon drawing. With 100+ images needed for a useful dataset, this becomes prohibitively costly. Standard solutions help only marginally: zero-shot models trained on internet images have never seen plant anatomy and produce unstable predictions, while traditional training requires annotating a complete batch before any model can be trained to provide assistance.

Live Training solves this by providing progressively better assistance from the first few annotations onward, eliminating the cold start problem entirely.

## **The Challenge: Domain-Specific Segmentation**

**Interactive segmentation models** like SAM \[\] provide some utility by detecting generic boundaries based on color and texture discontinuities. However, they require extensive manual guidance: an annotator must click 10-20 times per structure to refine masks, multiplied across 6-9 structures per image. For complex morphologies with irregular septum shapes or merged locules, this becomes trial-and-error refinement. The cognitive load of constant clicking and visual verification means interactive models only modestly improve upon manual polygon drawing.

Traditional **Human-in-the-Loop (HITL)** workflows create their own problems. An annotation project might proceed as follows:

**Week 1:** Plant scientist annotates 50 images manually, spending 10-15 minutes per image with zero model assistance. Total: 8-12 hours of expert time at 50 images.

**Week 2:** ML engineer receives the batch, configures training pipeline, runs experiments to find optimal hyperparameters, and trains the model. This requires coordination: "Are 50 images enough? Should we annotate more first? Which model architecture?" The training completes but model quality is uncertain.

**Week 3:** Annotator tests the model on new images and discovers predictions are marginally helpful but miss rare morphologies or confuse similar tissues. Decision point: annotate another 50 images or try different model settings? More coordination meetings.

**Week 4+:** Second iteration begins. The cycle repeats with diminishing returns on coordination overhead.

This workflow fragments a simple task (annotate tomatoes) into a multi-week, multi-team project with idle time at every step. While the annotator works, training resources sit unused. While training runs, the annotator waits. Each iteration requires human decisions about sample size, training parameters, and quality thresholds. The overhead isn't the annotation or training itself but the coordination and waiting between phases.

**Live Training** eliminates these inefficiencies through a single architectural change: annotation and training happen simultaneously. There are no batches to coordinate, no iteration planning, no idle time. The system starts with zero coordination overhead and stays there.

## **Live Training Workflow**

Setting up Live Training in Supervisely takes approximately two minutes. After creating a project and uploading images, enable Live Training in the labeling tool. The system handles everything automatically from there.

\[Image placeholder: Showing Live Training toggle in the labeling tool UI\]

The annotator begins with the first image, drawing polygons manually around each anatomical structure. This takes about 10 minutes for a complex cross-section. Upon saving and moving to the 3rd image, training starts automatically in the background. After completing 2-3 images manually, the model generates its first prediction.

Early predictions are partial and imperfect, correctly identifying major structures like pericarp but missing smaller components or confusing similar tissues. The annotator corrects predictions rather than drawing from scratch, reducing time per image from 10 minutes to 3-4 minutes. By images 5-7, predictions improve noticeably and annotation time drops to 1-2 minutes.

\[Image placeholder: Screenshot showing partial model prediction on image 4-5 with some structures identified\]

Around images 10-15, predictions become reliably accurate for most structures. Annotation shifts from active correction to quality assurance: review predictions, make minor adjustments, handle edge cases. Time per image drops to about a minute.

The annotator can monitor improvement through Running Evaluation metrics displayed in the interface, watching mIoU climb from 0.2 after 5 images to 0.75+ after 30 images.

\[Image placeholder: Graph showing "Time per image" decreasing from 10 min to 3-4 min over first 20 images\]

The entire workflow proceeds without coordination meetings, training cycle decisions, or interruptions. The annotator simply labels images sequentially and benefits from progressively better assistance. If work pauses, training pauses automatically and resumes when annotation continues.

## **Results**

We experimentally evaluated three annotation approaches on the Tomatoes Annotated dataset (30 images total) to quantify the practical benefits of Live Training against standard methods used in production annotation projects.

### **Approach 1: SAM Interactive Segmentation**

Using SAM for mask generation with manual refinement, an annotator completed all 30 images spending \[X\] total hours at \[Y\] minutes per image. Each image required approximately \[Z\] clicks to segment all nine anatomical structures. SAM detected generic boundaries based on color and texture changes, but the annotator still had to manually corect boundaries.

### **Approach 2: Traditional HITL**

The traditional Human-in-the-Loop workflow proceeded in two phases:

**Phase 1 (Images 1-15):** Manual annotation without assistance, taking \[X1\] minutes per image for a total of \[Y1\] hours. After completing this batch, the annotator handed off data to an ML engineer.

**Training period:** \[2-3 days\] of calendar time for model training, hyperparameter tuning, and quality validation. The annotator waited idle during this period.

**Phase 2 (Images 16-30):** Annotation with model assistance, taking \[X2\] minutes per image for a total of \[Y2\] hours. Predictions were helpful but required corrections for structures the model had limited exposure to in the first batch.

Total annotation time: \[Y1 \+ Y2\] hours over \[5-7 days\] calendar time, plus coordination overhead for batch handoff and model deployment.

### **Approach 3: Live Training**

Live Training eliminated distinct phases by providing progressively better assistance throughout the project:

**Images 1-3:** Manual annotation, \[X1\] minutes per image (\[Y1\] total hours). Model training began automatically in the background.

**Images 4-10:** Emerging assistance with partial predictions, \[X2\] minutes per image (\[Y2\] total hours). The annotator corrected and refined predictions rather than drawing from scratch.

**Images 11-30:** Strong assistance with reliable predictions, \[X3\] minutes per image (\[Y3\] total hours). Work shifted to quality assurance and edge case correction.

Total annotation time: \[Y1 \+ Y2 \+ Y3\] hours over \[2-3 days\] calendar time with zero coordination overhead.

### **Comparative Analysis**

\[Table 1: Annotation Approach Comparison\]

| Metric | SAM Interactive | Traditional HITL | Live Training |
| ----- | ----- | ----- | ----- |
| Total annotation time | \[X\] hours | \[Y\] hours | \[Z\] hours |
| Average time per image | \[X\] min | \[Y\] min | \[Z\] min |
| Calendar time | \[X\] days | \[Y\] days | \[Z\] days |
| Manual actions per image | \[X\] clicks | \[Y\] corrections | \[Z\] corrections |
| Model quality (mIoU) | N/A | \[X.XX\] | \[X.XX\] |
| Coordination points | 0 | 2-3 | 0 |
| Time to first assistance | immediately | \~3 days | \~15 min |
| Wait time | 0 | \[X\] days | 0 |

\[Figure 1 placeholder: Line graph showing cumulative annotation time\]

* X-axis: Image number (1-30)  
* Y-axis: Cumulative hours spent  
* Three lines: SAM (linear), HITL (two segments with gap), Live Training (curve that flattens)  
* Visual shows Live Training becoming more efficient than SAM around image 12-15 and matching HITL total time despite starting from scratch

## **Getting Started with Your Dataset**

TBD

