Currently Neural Networks are the methods of choice for dealing with most computer vision tasks. With Supervisely, you can train neural networks on your images, control and visualize training process. After the model is ready, you can apply it to recognize your images or download the model and use it in your products.

Neural networks are at the heart of Supervisely and  extend Supervisely functionality in the following ways:

- **Access to State-Of-The-Art models.** You will find a large collection of State-Of-The-Art models in Supervisely model collection that you can train and use in your products. Some of the available models are listed below:
    - UNet
    - Mask R-CNN
    - YOLO v3
    - DeepLab v3
    - MobileNet SSD
    - PSPNet
    - ICNet
    - Faster-RCNN
    - and others

- **Research automatization.** Building a neural network that provides desired levels of accuracy might require a lot of “training procedures”. It is very important to treat the process systematically - to be able to save, review and reproduce the results of experiments, share the results with other team members. The Supervisely was designed to automate research processes

- **Human-in-the-loop.** Human-in-the-loop approach is known to be effective when you need to perform image annotation faster.

- **Usage of pre-trained models.** Often, a computer vision system is built to handle "well-known" objects, such as people or cars. For such cases,  there are a number of pre-trained models in the collection. These models can be used as a ready-to-use-component through API, or for speeding up the annotation process.

- **Integration of custom models.** Docker technology makes it easy to integrate your custom neural networks into Supervisely. Just implement simple API and put your code into docker image.

- **Smart tool optimization for segmenting specific objects on the images.** Smart Tool allows to do pixelwise annotation with minimum number of clicks. To adapt Smart Tool for your specific object you can train it within Supervisely.


Please use the left menu to read more about neural networks.
