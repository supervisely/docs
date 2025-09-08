# Model Evaluation Benchmark

## Overview

After training a model, it is crucial to evaluate it on a validation set to assess its performance. Supervisely provides you a built-in evaluation benchmark that **automatically** runs after each model training experiment. Our evaluation benchmark has a large set of evaluation tools, visualizations, and metrics to help you understand how well does your model actually performs.

**Supervisely offers the most advanced evaluation tool on the market!**

![Benchmark Report Example](../../.gitbook/assets/benchmark_report.gif)

### Supported Task Types

Evaluation Benchmark now supports the following **task types**:
- [Object Detection](./object-detection.md)
- [Instance Segmentation](./instance-segmentation.md)
- [Semantic Segmentation](./semantic-segmentation.md)

## How to Open Evaluation Results

After training, you can open the evaluation results either from the training session (application) where the model was trained or from the **[Experiments](../training/experiments.md)** table in Supervisely. The second option is more convenient, because the Experiments table organizes all your training experiments in one place. To open the evaluation results, find the experiment you are interested in, and click on **Evaluation Report** link.

![Open Evaluation from Experiments](/.gitbook/assets/neural-networks/model-benchmark/open-evaluation-from-table.png)

## Compare Evaluation Results

You can also compare different models that were trained on the same dataset side-by-side. This is also possible from the **Experiments** table. Select two or more experiments, and click on the **Compare** button in the dropdown menu.

![Compare Experiments](/.gitbook/assets/neural-networks/training/compare-training-metrics1.jpg)

## Run Evaluation & Comparison Manually via Apps

The evaluation is run automatically after each training experiment if you did not disable it in the training configuration. However, you can also run the evaluation manually on any dataset or a model using the following app:

- [Evaluator for Model Benchmark](https://ecosystem.supervisely.com/apps/model-benchmark)

In this case, you need first to deploy your model manually using a corresponding serving app (e.g., **Serve YOLO**, **Serve DEIM**). Then launch the **Evaluator for Model Benchmark** app, select the model and the Ground Truth project, and click **Evaluate**. This will run your model on the selected dataset and generate the evaluation report with all the metrics and visualizations.