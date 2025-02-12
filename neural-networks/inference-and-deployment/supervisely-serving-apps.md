## Overview

This section covers the deployment and inference of models using **Supervisely Serving Apps**. This is a simple way to deploy a model on the Supervisely Platform with a convenient web UI. It allows you to deploy both the pretrained models, such as YOLOv8, and your own models trained in Supervisely.

After you've deployed a model, you can interact with it in different ways:

1. **Apply model in platform:** You can predict easily with NN Applying apps. They allows you to predict the entire Projects or datasets: [Apply NN to Images](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset), [Apply NN to Videos](https://ecosystem.supervisely.com/apps/apply-nn-to-videos-project).
2. **Inference via API:** Every model deployed in the Supervisely Platform acts like a server that is ready to process inference requests via API. You can communicate with the model using Supervisely SDK (see the [Inference API Tutorial](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial)), which has convenient methods for efficient model inference on images, projects, and videos. We also support Tracking-by-detection algorithms, such as BoT-Sort.