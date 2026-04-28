# Introduction

Live Training is a novel annotation approach in which a computer vision model trains in parallel with the manual annotation. It allows the model to quickly adapt to the domain-specific patterns of your dataset and effectively assist in labeling from the very start of the annotation project, improving continuously from the first labeled image onward.

# Motivation

Data annotation remains one of the most resource-intensive bottlenecks in applied computer vision. Labeling a high quality dataset typically requires thousands of annotator-hours and weeks of calendar time. The costs scales with every new domain, edge case, and project iteration.

The computer vision community has responded with a wave of powerful foundation models — SAM 3 [1], Grounding DINO [2], Florence 2 [3], and others — designed to reduce manual effort through zero-shot and open-vocabulary prediction. These models represent genuine progress: they work out of the box, require no training data, and can accelerate labeling on common object categories.

Yet despite this progress, projects requiring domain-specific datasets still remain expensive and complex.

We identified foundational inefficiencies common to all AI-assisted labeling approaches:

1. **Zero-shot foundation models do not adapt to domain-specific tasks.** They provide consistent predictions but never adapt – the 1st and 1,000th image receive identical annotation assistance. They also work best on common object categories such as people or vehicles, and tend to underperform on specialized domains. We found that SAM 2 [4] on domain-specific data offered almost no time savings: the model's imprecise boundaries required so much manual correction that it negated any assistance it provided.   
2. **Sequential workflows create coordination overhead and idle time.** In batch-based approaches (Human-in-the-loop, Active Learning) annotation and training must take turns: annotators or domain experts label a batch of images over several days, then wait while ML engineers train a model. Meanwhile, when annotators work, training GPUs and ML engineers sit idle. Each cycle requires cross-team coordination and involves human decisions about resource allocation, training configurations and quality assurance of data and models. This fragmentation inevitably results in greater waste of time and resources.

Together, these two problems mean that companies are paying full price for annotation while getting diminishing help from AI. 

Live Training addresses these inefficiencies through a single architectural shift: running annotation and model training in parallel, continuously. As annotators label each image, the system immediately incorporates it into the training process. When they open the next image, they receive predictions (pre-labels) from a model that has already learned from all previous samples. The quality of these predictions continuously improves with every new image labeled. 

This approach transforms annotation projects from a multi-week, multi-team coordination challenge into a single-phase workflow where AI assistance grows naturally from the first annotation onward. There are no batches to coordinate, no training cycles to schedule, no additional decisions required. ML engineers configure the system once, and it runs automatically. By project completion, you get both a fully annotated dataset and a trained model with accuracy comparable to a model trained through conventional offline training.

# Background and Related Work

**Human-in-the-Loop (HITL)** has become the industry standard for efficient data annotation, representing a significant improvement over traditional offline pipelines where datasets were labeled entirely before any model training began. HITL introduces iterative cycles: annotate a small batch, train a model on that data, use the model's predictions to pre-label the next batch, then repeat. Annotators shift from drawing annotations from scratch to correcting model predictions — a faster and less demanding task. The approach also reduces project risk: teams can evaluate model performance after each iteration and adjust their annotation strategy before committing to a full dataset.

Despite these advantages, HITL doesn't eliminate the core inefficiency — it structures it into cycles. Annotation and training still take turns, coordination overhead remains, and the AI assistance an annotator receives is always a version behind.

**Active Learning** addresses the question of *which* samples to annotate, intelligently selecting images where model predictions are most uncertain or most representative of unlabeled data. Early work on uncertainty sampling and diversity-based selection showed that careful sample selection could meaningfully reduce annotation requirements compared to random sampling. More recently, deep Active Learning methods leverage neural network representations for more sophisticated selection strategies [7].

However, the effectiveness of Active Learning is highly budget-dependent. In low-budget regimes — where only a small initial labeled set is available — uncertainty-based strategies frequently underperform random selection, as the model's uncertainty estimates are unreliable when trained on too few examples [5, 6]. Representation-based methods such as TypiClust [5] partially address this, but the cold-start problem remains a fundamental challenge for any Active Learning approach.

Regardless of the selection strategy, Active Learning retains the same sequential structure as HITL: annotation and training alternate in cycles. Smarter sample selection reduces the *number* of labels needed, but does not eliminate the coordination overhead, idle time, or batch-based fragmentation inherent to the workflow.

**Semi-Supervised Learning (SSL)** takes a different approach: rather than optimizing which samples to label, it extracts useful signal from unlabeled data itself. Methods like pseudo-labeling [8] — where the model generates provisional labels for unlabeled images and trains on them — and consistency regularization [9, 10] — where the model is trained to produce stable predictions under input perturbations — can meaningfully reduce the number of human-labeled samples needed to reach target accuracy.

SSL integrates naturally with HITL pipelines, particularly in early iterations when labeled data is scarce and the unlabeled pool is large. However, like Active Learning, it operates entirely within the batch-based paradigm. Both approaches optimize *what* to label or *how* to train more efficiently — but neither eliminates the fundamental alternation between annotation and training that drives coordination overhead and idle time.

**Zero-shot foundation models.** Vision-language models such as Grounding DINO [2], Florence-2 [3], YOLO-World [11], OWL-ViT [12], and CLIP [13] are trained on large-scale collections of image-text pairs, enabling open-vocabulary object detection and segmentation from natural language prompts without task-specific training. These models can detect a wide range of object categories and generalize to related concepts through learned visual-semantic correspondences. For common objects — people, vehicles, animals, everyday items — they provide remarkably effective out-of-the-box annotation assistance.

However, zero-shot performance degrades sharply when target objects fall outside the model's training distribution. In domain-specific applications such as semiconductor defect detection, medical pathology imaging, or specialized infrastructure inspection, these models offer minimal help: the visual patterns and object categories involved are largely absent from internet-scale image collections on which these models are trained.

**Interactive segmentation models.** The SAM family [14, 4, 1] has become widely adopted in projects requiring mask annotations. Rather than generating automatic predictions, these models let annotators refine boundaries through clicks and prompts. Unlike semantic foundation models, SAM was trained to respond to generic visual cues — edges, color discontinuities, texture transitions — that transfer across domains more reliably than semantic understanding does. This makes it considerably more robust to domain shift than classification-based models: a boundary between tissue and background in a medical scan shares low-level structure with a boundary between a component and its mounting surface in an industrial inspection image. That said, robustness is not universally guaranteed — performance in automatic mode can degrade in specialized domains, and the model remains dependent on prompt quality [15].

The fundamental limitation of interactive segmentation models is manual effort: every object in every image requires individual guidance. And like zero-shot models, they never learn from your data — there is no mechanism by which annotation work accumulated over a project improves future predictions.

**None of the approaches above enables continuous model adaptation during annotation** — where each newly labeled image contributes to a model that improves throughout the project, without discrete training cycles, cross-team coordination, or interruptions to the annotation workflow. This is the gap Live Training addresses. 

# How Live Training Works

Live Training is built on a single design principle: the model trains continuously alongside annotation, on the same GPU, with no separation between the training and deployment phases.

In practice, this works as follows. As soon as an annotator completes two images, training begins — the model starts updating its weights in the background using the labeled data accumulated so far. When the annotator opens the next image, training is briefly paused, the model switches to inference mode, and predictions are generated from the latest model state. The annotator receives pre-labels reflecting everything the model has learned up to that moment. When they correct the annotation and confirm it, that sample is immediately added to the training dataset.

![Live Training Diagram](/.gitbook/assets/live-training/live-training-diagram.png)

Four technical components make this possible and reliable at scale:

* **Foundation model initialization** ensures meaningful predictions emerge after just 2-5 labeled images, long before a conventionally trained model would produce anything useful.  
* **Frequency Batch Sampler** dynamically rebalances how often each sample is seen during training, preventing the model from overfitting to early annotations as the dataset grows.  
* **Live Evaluation** provides real-time model quality metrics with zero additional overhead, by comparing the model's pre-label predictions against the ground truth annotations that annotators produce.  
* **Training infrastructure** — a dynamic dataloader, concurrent training and inference on a single GPU using a single model state, and graceful pause and resume — ties the system together into a production-ready workflow.

By the time annotation is complete, the team has both a fully labeled dataset and a trained model — without a separate training phase, and without ever leaving the annotation interface.

### **Training Lifecycle**

Training begins automatically after a minimum two images have been labeled. The first two images are labeled manually using standard tools for annotation, other AI-assisted models can be used too. Once the model completes its first training steps and reaches non-zero accuracy on Live Evaluation metrics, it begins providing predictions automatically for each new image. As annotators work, the model trains in the background on the labeled data accumulated so far.

**Inference during training.** When an annotator opens a new image, training is briefly paused after the current training step completes, the model switches to evaluation mode, and predictions are generated. This pause is fast enough to be imperceptible — comparable to the time it takes to load the next image from the server. The annotator receives predictions from the latest model state. Once predictions are returned, training resumes immediately.

**Pause and resume.** Training does not run uncontrollably. A \`LossPlateauDetector\` monitors training dynamics and pauses model optimization when the loss stops improving — preventing the model from overfitting to the small initial dataset before new annotations arrive. When an annotator labels a new image and it is added to the training set, training resumes automatically from the exact state where it stopped. No training state is lost during a pause: GPU memory remains allocated and the model weights are preserved.

**Frequency Batch Sampler.** In conventional training, datasets are shuffled uniformly each epoch, ensuring equal sampling probability across all samples. This assumption breaks in Live Training: early labeled samples would be seen hundreds of times while recent additions barely appear in training batches, creating severe bias to early samples. We introduce Frequency Batch Sampler to dynamically rebalance sampling probabilities. As the dataset grows, the sampler shifts focus toward recent data while preserving diversity across the full dataset.

**Live Evaluation.** Traditional training relies on held-out validation sets to monitor progress and detect overfitting. Live Training, especially in early stages, has insufficient data for statistically meaningful validation, yet validation is critical due to unpredictable annotation pacing and continuous distribution drift. We leverage an inherent property of the annotation workflow: each time an annotator opens a new image, the model generates a prediction to provide pre-labeling assistance. We save this prediction, and when the annotator completes the image, we compute accuracy metrics by comparing the prediction against the final ground truth annotation. To make this robust to single-sample noise, we maintain an exponential moving average of metrics across recent evaluations. This approach provides real-time quality monitoring with zero computational overhead (predictions are already generated for annotation assistance) and 100% data efficiency (every sample contributes to both training and validation).

### **Foundation Model Initialization**

A natural concern with any continuous learning system is cold start: how useful can a model be after only two or three labeled images? Live Training addresses this through careful model selection and initialization.

Rather than training from random weights, Live Training initializes from foundation models pre-trained on large, diverse datasets. The specific model depends on the task: **MM Grounding DINO** [16] for object detection, and **Mask2Former** [17] for instance and semantic segmentation. Both are fine-tuned during Live Training allowing the model to adapt to the target domain.

The practical impact of this initialization is significant. In few-shot experiments on specialized datasets — semiconductor defect inspection and medical imaging — models initialized from multi-dataset pre-training (COCO, Objects365, GRIT, V3Det) achieve **0.41 mAP with just 5 training samples**. By comparison, models initialized only on COCO reach 0.10 mAP under the same conditions, and randomly initialized models fail to produce meaningful predictions entirely. This gap explains why useful predictions emerge after 3–5 annotations rather than the hundreds typically required to train a domain-specific model from scratch.

**A note on catastrophic forgetting.** Full fine-tuning on a small and rapidly growing dataset raises a legitimate concern: as the model adapts to domain-specific patterns, could it lose the general visual priors that make early predictions possible? In our experiments, catastrophic forgetting did not occur. We attribute this to the strong representational priors embedded in the foundation model weights — they appear to act as a stable initialization that resists degenerating under limited data fine-tuning.

### **Infrastracture**

**Dynamic dataset growth.** Conventional training dataloaders are initialized once against a fixed dataset. Live Training requires a dataloader that accepts new samples mid-training — without restarting the training process, or interrupting the current batch. We built this capability into the Supervisely framework, allowing samples to be enqueued from the annotation interface and picked up by next training batches. 

**Labeling interface integration.** Live Training is embedded directly into the Supervisely labeling interface — annotators interact with a standard labeling tool that happens to be backed by a continuously updating model. Pre-label predictions appear automatically on each new image without any manual trigger. A live metrics panel displays model quality scores updated after each annotation, powered by Live Evaluation. Annotators can see the model improving in real time as the session progresses. 

**Hardware requirements.** Live Training runs on a single GPU with 10–14 GB of VRAM, making it compatible with consumer-grade hardware such as an NVIDIA RTX 3090 or newer.

# Comparing annotation approaches

We created a simulating model to visualize and compare 4 annotation approaches on a segmentation project. The point is to simulate the underlying mechanics so the comparison is clear and close to reality.

**The setup**

A segmentation project with 10,000 images. One annotator. Four approaches:

1. **Manual annotation** — brush, polygon, pen tool. No model assistance.  
2. **SAM 3 (promptable)** — a strong pre-trained foundation model. The annotator gives prompts (clicks, boxes); the model produces masks. Fast, but doesn't adapt to the dataset.  
3. **HITL (human-in-the-loop)** — bootstrap manually until you have enough data to train, then train a model, then review its pre-labels, then train again with more data, and so on. Discrete retraining cycles.  
4. **Live Training** — the model trains continuously alongside the annotator. Every newly labeled image flows into the next training step. There is no retrain "event"; the model is always the most current version it can be.

To compare these approaches, we estimate the time required to annotate 10,000 images.

**Note:** Real-world results depend on task complexity, data characteristics, model quality, and annotator performance. The values used here are averages drawn from our experience with similar projects.

**Parameters and assumptions:**

- **Manual annotation (baseline):** 3.5 minutes per image with basic tools and no AI assistance.  
- **SAM 3:** 90 seconds per image — depending on the task this may vary, but it is consistently faster than manual annotation (2.3× faster in our example).  
- **HITL:** The model is retrained at 200, 1,000, 2,000, and 5,000 labeled images (four cycles). Each retraining cycle takes 1 calendar day, during which annotation is paused. In practice, retraining can take considerably longer and may require data scientists and cross-team coordination. After each retraining, the updated model must be applied to unlabeled samples to generate pre-labels.  
- **Review-only cap:** We set the time for an annotator to review a pre-labeled image at 30 seconds. This is the irreducible cost of a human verifying a model's prediction — even with a perfect model, this floor cannot be beaten.  
- **Annotator working hours:** 6 hours per day. This is used to express results in calendar days rather than raw uninterrupted hours, which would not reflect real working conditions.

### Results:

**Plot 1. Annotation progress vs calendar days.** This plot shows the timeline of an annotation project across all four approaches. The x-axis is calendar time (including both annotation and training periods); the y-axis is cumulative progress (% of dataset labeled). In the first \~10 hours, SAM 3 outperforms Live Training and HITL, thanks to its pre-trained foundation knowledge. Later, Live Training quickly takes the lead due to its continuous adaptation to new data. HITL follows the same trend but with a notable time lag caused by its discrete retraining schedule.

![Annotation Progress vs Calendar Days](/.gitbook/assets/live-training/4_progress_vs_days.png)

**Plot 2. Annotation progress vs working time.** This chart measures elapsed time in hours, as if annotators worked nonstop. Overall trends are similar to Plot 1\. Live Training reaches 100% in approximately 102 working hours. HITL takes around 145 working hours — 35% longer — due to bootstrap overhead and four training pauses. SAM 3 takes 250 hours; fully manual annotation takes 583 hours.  
![Annotation Progress vs Working Time](/.gitbook/assets/live-training/2_progress_vs_time_hours.png)

The table below summarizes the total working hours and calendar days each approach takes to complete the annotation project:

| Approach | Working hours | Calendar days |  
|---|---|---|  
| Manual | 583 h | **97 d** |  
| SAM 3 | 250 h | **42 d** |  
| HITL | 145 h | **24 d** |  
| Live Training | 102 h | **17 d** |

Compared to HITL, Live Training begins assisting annotators after the very first labeled images — much earlier in absolute terms. HITL requires at least 100-200 images labeled before the first retrain, which is a significant time investment at manual speed.

The comparison with **SAM 3** is also worth noting. A strong promptable foundation model is hard to beat without domain-specific training: SAM 3 alone outperforms HITL during the bootstrap phase (~70 hours). HITL only becomes meaningfully better than SAM 3 once it has its first domain-trained model. Live Training surpasses SAM 3 within the first ~10 hours and maintains that advantage throughout.

**Plot 3. Annotation speed vs working time.** This is another view of the same experiment showing momentary annotation rate across the project. Live Training rises smoothly from manual speed up to the review-only cap, approaching that plateau after roughly 40 working hours. HITL is a stairstep with four flat-zero gaps where training pauses occur. Manual labeling and SAM 3 appear as flat lines — SAM 3 does not adapt to the data, so its speed is independent of how much has already been annotated.  

![Annotation Speed vs Working Time](/.gitbook/assets/live-training/1_speed_vs_time.png)

**Plot 4. Annotation speed vs images labeled.** Here the x-axis is replaced with the count of images labeled rather than elapsed time. With time removed, the relationship between the four methods becomes purely geometric: HITL is a piecewise-constant approximation of the Live Training curve, sampled at four retrain points. The two converge near the right edge, where any model trained on sufficient data reaches the review-only cap. SAM 3 appears as a flat line that HITL crosses immediately after its first retrain — meaning a model trained on just 200 domain-specific images already outperforms SAM 3 on this task.

![Annotation Speed vs Images Labeled](/.gitbook/assets/live-training/3_speed_vs_images_labeled.png)

# References

[1] Carion, N., Gustafson, L., Hu, Y.-T., et al. (2025). *SAM 3: Segment Anything with Concepts*. arXiv:2511.16719. https://arxiv.org/abs/2511.16719

[2] Liu, S., Zeng, Z., Ren, T., et al. (2024). *Grounding DINO: Marrying DINO with Grounded Pre-Training for Open-Set Object Detection*. ECCV 2024. https://www.ecva.net/papers/eccv_2024/papers_ECCV/html/6319_ECCV_2024_paper.php

[3] Xiao, B., Wu, H., Xu, W., et al. (2024). *Florence-2: Advancing a Unified Representation for a Variety of Vision Tasks*. CVPR 2024. https://openaccess.thecvf.com/content/CVPR2024/html/Xiao_Florence-2_Advancing_a_Unified_Representation_for_a_Variety_of_Vision_CVPR_2024_paper.html

[4] Ravi, N., Gabeur, V., Hu, Y.-T., et al. (2024). *SAM 2: Segment Anything in Images and Videos*. arXiv:2408.00714. https://arxiv.org/abs/2408.00714

[5] Hacohen, G., Dekel, A., & Weinshall, D. (2022). *Active Learning on a Budget: Opposite Strategies Suit High and Low Budgets*. ICML 2022. https://proceedings.mlr.press/v162/hacohen22a.html

[6] Siméoni, O., Budnik, M., Avrithis, Y., & Gravier, G. (2021). *Rethinking Deep Active Learning: Using Unlabeled Data at Model Training*. ICPR 2020. https://arxiv.org/abs/1911.08177

[7] Gupte, S. R., Aklilu, J., Nirschl, J. J., & Yeung-Levy, S. (2024). *Revisiting Active Learning in the Era of Vision Foundation Models*. TMLR. https://openreview.net/forum?id=u8K83M9mbG

[8] Lee, D.-H. (2013). *Pseudo-Label: The Simple and Efficient Semi-Supervised Learning Method for Deep Neural Networks*. ICML 2013 Workshop on Challenges in Representation Learning. https://www.semanticscholar.org/paper/Pseudo-Label-%3A-The-Simple-and-Efficient-Learning-Lee/798d9840d2439a0e5d47bcf5d164aa46d5e7dc26

[9] Sajjadi, M., Javanmardi, M., & Tasdizen, T. (2016). *Regularization With Stochastic Transformations and Perturbations for Deep Semi-Supervised Learning*. NeurIPS 2016. https://proceedings.neurips.cc/paper/2016/hash/30ef30b64204a3088a26bc2e6ecf7602-Abstract.html

[10] Laine, S., & Aila, T. (2017). *Temporal Ensembling for Semi-Supervised Learning*. ICLR 2017. https://openreview.net/forum?id=BJ6oOfqge

[11] Cheng, T., Song, L., Ge, Y., Liu, W., Wang, X., & Shan, Y. (2024). *YOLO-World: Real-Time Open-Vocabulary Object Detection*. CVPR 2024. https://openaccess.thecvf.com/content/CVPR2024/html/Cheng_YOLO-World_Real-Time_Open-Vocabulary_Object_Detection_CVPR_2024_paper.html

[12] Minderer, M., Gritsenko, A., Stone, A., et al. (2022). *Simple Open-Vocabulary Object Detection with Vision Transformers*. ECCV 2022. https://arxiv.org/abs/2205.06230

[13] Radford, A., Kim, J. W., Hallacy, C., et al. (2021). *Learning Transferable Visual Models From Natural Language Supervision*. ICML 2021. https://proceedings.mlr.press/v139/radford21a.html

[14] Kirillov, A., Mintun, E., Ravi, N., et al. (2023). *Segment Anything*. ICCV 2023. https://openaccess.thecvf.com/content/ICCV2023/html/Kirillov_Segment_Anything_ICCV_2023_paper.html

[15] Lian, S., & Li, H. (2024). *Evaluation of Segment Anything Model 2: The Role of SAM2 in the Underwater Environment*. arXiv:2408.02924. https://arxiv.org/abs/2408.02924

[16] Zhao, X., Chen, Y., Xu, S., et al. (2024). *An Open and Comprehensive Pipeline for Unified Object Grounding and Detection* (MM-Grounding-DINO). arXiv:2401.02361. https://arxiv.org/abs/2401.02361

[17] Cheng, B., Misra, I., Schwing, A. G., Kirillov, A., & Girdhar, R. (2022). *Masked-attention Mask Transformer for Universal Image Segmentation*. CVPR 2022. https://openaccess.thecvf.com/content/CVPR2022/html/Cheng_Masked-Attention_Mask_Transformer_for_Universal_Image_Segmentation_CVPR_2022_paper.html
