Supervisely suppports most of the state of the art models for common computer vision tasks:

* [Interactive segmentation](#interactive_segmentation)

* [Semantic segmentation](#semantic_segmentation)

* [Instance segmentation](#instance_segmentation)

* [Object Detection](#object_detection)

* [Classification](#classification) 

* [Text detection](#text_detection) 

* [OCR](#ocr) 


{% hint style="success" %}
All neural networks architectures (listed below) support both training and inference inside the Supervisely Platform. Also we provide pretrained weights for each architecture that can be used directly for inference or for transfer learning to speed up the training process on your custom data.
{% endhint %}

{% hint style="success" %}
We aslo provide source codes for all neural networks so developers can customize them. Read more in the SDK chapter. 
{% endhint %}


<!--
https://www.tablesgenerator.com/html_tables
-->


## <a id="interactive_segmentation"></a> Interactive segmentation

| Architecture | Pretrained on | Framework | Paper        | 
| ------------ | ------------- | --------- | ------------ |
| Smart Tool   | Custom data   | PyTorch   | [Medium](https://hackernoon.com/%EF%B8%8F-big-challenge-in-deep-learning-training-data-31a88b97b282)|
|              | Custom data + Supervisely Person | | [Medium1](https://hackernoon.com/%EF%B8%8F-big-challenge-in-deep-learning-training-data-31a88b97b282), [Medium2](https://hackernoon.com/releasing-supervisely-person-dataset-for-teaching-machines-to-segment-humans-1f1fc1f28469) |

## <a id="semantic_segmentation"></a> Semantic segmentation

| Architecture           | Pretrained on | Framework  | Paper        |
| ------------           | ------------- | ---------  | ------------ |
| Unet V2 (based on VGG) | ImageNet      | PyTorch    | [arxiv](https://arxiv.org/abs/1505.04597) |
| PSPNet                 | Cityscapes    | Tensorflow | [arxiv](https://arxiv.org/abs/1612.01105) |
|                        | ADE20K        |            |                                           |
| ICNet                  | Cityscapes    | Tensorflow | [arxiv](https://arxiv.org/abs/1704.08545) |
|                        | ADE20K        |            |                                           |
| DeepLab V3 +           | Cityscapes    | Tensorflow | [arxiv](https://arxiv.org/abs/1802.02611) |
|                        | ADE20K        |            |                                           |


## <a id="instance_segmentation"></a> Instance segmentation

| Architecture          | Backbone            | Pretrained on      | Framework     | Paper        |
| ------------          | --------            | -------------      | ---------     | ------------ |
| Mask-RCNN             | Inception V2        | COCO               | Tensorflow    | [arxiv](https://arxiv.org/abs/1703.06870) |
|                       | ResNet-50 (atrous)  | COCO               |               |                                           |
|                       | ResNet-101 (atrous) | COCO               |               |                                           |


## <a id="object_detection"></a> Object detection

| Architecture          | Backbone             | Pretrained on      | Framework        | Paper        |
| ------------          | --------             | -------------      | ---------        | ------------ |
| YOLO V3               |                      | COCO               | DarkNet (C++)    | [arxiv](https://arxiv.org/abs/1904.04620) |
| SSD                   | Inception V2         | COCO               | Tensorflow       | [arxiv](https://arxiv.org/abs/1512.02325) |
|                       | MobileNet V1         | COCO               |                  |                                           |
|                       | MobileNet V2         | COCO               |                  |                                           |
|                       | MobileNet V2 (lite)  | COCO               |                  |                                           |
| Faster-RCNN           | ResNet-50            | COCO               | Tensorflow       | [arxiv](https://arxiv.org/abs/1506.01497) |
|                       | ResNet-101           | COCO               |                  |                                           |
|                       | Inception V2         | COCO               |                  |                                           |
|                       | Inception ResNet V2 (atrous) | COCO       |                  |                                           |
|                       | NasNet               | COCO               |                  |                                           |
|                       | NasNet (lowproposals)| COCO               |                  |                                           |
| RFCN                  | ResNet-101           | COCO               | Tensorflow       | [arxiv](https://arxiv.org/abs/1605.06409) |


## <a id="classification"></a> Classification

<!--
https://pytorch.org/docs/master/torchvision/models.html
-->

| Architecture          | Backbone             | Pretrained on      | Framework        | Paper        |
| ------------          | --------             | -------------      | ---------        | ------------ |
| AlexNet               |                      | ImageNet           | PyTorch          | [arxiv](https://www.nvidia.cn/content/tesla/pdf/machine-learning/imagenet-classification-with-deep-convolutional-nn.pdf) |
| VGG                   | *-11                 | ImageNet           | PyTorch          | [arxiv](https://arxiv.org/abs/1409.1556) |
|                       | *-13                 | ImageNet           |                  |                                           |
|                       | *-16                 | ImageNet           |                  |                                           |
|                       | *-19                 | ImageNet           |                  |                                           |
|                       | *-11 with batchnorm  | ImageNet           |                  |                                           |
|                       | *-13 with batchnorm  | ImageNet           |                  |                                           |
|                       | *-16 with batchnorm  | ImageNet           |                  |                                           |
|                       | *-19 with batchnorm  | ImageNet           |                  |                                           |
| ResNet                | *-18                 | ImageNet           | PyTorch          | [arxiv](https://arxiv.org/abs/1512.03385) |
|                       | *-34                 | ImageNet           |                  |                                           |
|                       | *-50                 | ImageNet           |                  |                                           |
|                       | *-101                | ImageNet           |                  |                                           |
|                       | *-152                | ImageNet           |                  |                                           |
| SqueezeNet            | *-1.0                | ImageNet           | PyTorch          | [arxiv](https://arxiv.org/abs/1602.07360) |
|                       | *-1.1                | ImageNet           |                  |                                           |
| Densenet              | *-121                | ImageNet           | PyTorch          | [arxiv](https://arxiv.org/abs/1608.06993) |
|                       | *-169                | ImageNet           |                  |                                           |
|                       | *-201                | ImageNet           |                  |                                           |
|                       | *-161                | ImageNet           |                  |                                           |
| Inception V3          |                      | ImageNet           | PyTorch          | [arxiv](https://arxiv.org/abs/1512.00567) |


## <a id="text_detection"></a> Text detection

| Architecture           | Pretrained on | Framework  | Paper        |
| ------------           | ------------- | ---------  | ------------ |
| EAST                   | ICDAR 2015    | Tensorflow | [arxiv](https://arxiv.org/abs/1704.03155) |
| CTPN                   | ICDAR 2015    | Tensorflow | [arxiv](https://arxiv.org/abs/1609.03605) |
| PixelLink              | ICDAR 2015    | Tensorflow | [arxiv](https://arxiv.org/abs/1801.01315) |

## <a id="ocr"></a> OCR

| Architecture           | Pretrained on | Framework  | Paper        |
| ------------           | ------------- | ---------  | ------------ |
| CNN-LSTM-CTC           | ICDAR 2015    | Tensorflow | [arxiv](https://www.cs.toronto.edu/~graves/icml_2006.pdf) |


