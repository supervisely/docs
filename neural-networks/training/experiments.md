# Training Experiments

Supervisely tracks all your training experiments and provides a strategic way to manage them, which makes working with your trained models much easier and comprehensive. You can find your experiments in the **Experiments** section of the right sidebar in the Supervisely platform. Here, you can see a table with your experiments and their details, such as model and framework, training data, hyperparameters, evaluation metrics with the full model benchmark report, and tensorboard logs.

<!-- *You can also filter and sort the experiments by various criteria. You can also compare the evaluation results of different models and visually understand their behavior in different scenarios. You can deploy your final models directly from the experiments table, which allows you to quickly apply the models to your data. Finally, you can start a new experiment by clicking the **New Experiment** button in the top right corner of the page. This will open a form where you can set up the experiment configuration, and run the training process.* -->

![Experiments](/.gitbook/assets/neural-networks/training/experiments.png)

## Motivation

Training neural networks is a complex process that involves many steps, such as data preparation, model selection, hyperparameter tuning, and evaluation. Each of these steps can have a significant impact on the final results. Therefore, it is essential to keep track of all the experiments you run, their configuration details, as well as the results. Supervisely Experiments provides a strategic way in addressing this complexity, representing all your training runs in an extensive table. It allows you to analyze experiments in detail, compare their evaluation results, deploy the best-performing models and apply them to your data in a few clicks.

## Features

- **Experiment Tracking**: Supervisely automatically tracks all your training experiments, including the model, framework, training data, hyperparameters, the full evaluation report, and tensorboard logs.
- **Experiment Management**: You can manage your experiments, such as filtering, sorting, and searching for specific experiments.
- **Model Comparison**: You can compare the evaluation benchmark results of different models to analyze their performance and visually understand their behavior in different scenarios.
- **View Tensorboard logs**: You can view the tensorboard logs of the training process.
- **Model Deployment & Inference**: You can deploy your final models directly from the experiments table. This allows you to quickly apply the models to your data.
- **Start New Experiment**: You can start a new experiment by clicking the **New Experiment** button in the top right corner of the page. This will open a form where you can set up the experiment configuration and run the training process.
- **Continue Training**: You can continue training your trained model with new data or hyperparameters.

## Experiment Details

You can click on any experiment in the table to view its details. The experiment details page provides a comprehensive overview of the experiment.

![Experiment Details](/.gitbook/assets/neural-networks/training/experiment-page.png)

It includes the following sections:

- **Training Information**: The experiment name, model, framework, computer vision task, device, training duration, base checkpoint in case of transfer learning.
- **Training Data**: The dataset and project used for training, as well as the number of images in the training and validation sets.
- **Hyperparameters**: The hyperparameters used for training, such as learning rate, batch size, number of epochs, and other parameters specific to the model and framework.
- **Evaluation Metrics**: The evaluation metrics of the model, such as accuracy, precision, recall, F1 score, and other metrics specific to the CV task. You can also view the full evaluation report with detailed metrics and visualizations.
- **Predictions**: You can view the predictions made by the model on the validation dataset.
- **Training Logs**: You can open tensorboard logs and charts of the training process.
- **Checkpoints**: You can view and manage the checkpoints created during the training process, as well as the best checkpoint based on the evaluation metrics.
- **Inference & Deployment**: You can deploy the model directly from the experiment details page. This allows you to quickly apply the model to your data and start making predictions.
- **Finetune**: You can finetune your model on new data or with different hyperparameters to improve its performance. This allows you to continue training your model without starting from scratch.
- **Code examples & API usage**: You can find all the code examples and usage instructions for the model in the experiment details page. This allows you to quickly understand how to use the model inside and outside Supervisely platform.