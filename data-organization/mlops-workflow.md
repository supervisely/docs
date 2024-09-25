---
hidden: true
---

# MLOps Workflow

The workflow on Supervisely is a visual and systematic representation of the sequence of actions and tools applied to data during each stage of a computer vision and machine learning project. This workflow ensures traceability, version control, efficient project management, collaboration, and easy navigation for any project developed on the platform.

### Inspirations behind workflow creation

The workflow concept on the Supervisely platform draws inspiration from several principles:

**Simplicity and visualization:** Inspired by the need for transparency in machine learning processes, the workflow provides an easy-to-understand visual representation of complex steps, giving users a clear view of each step.&#x20;

**Collaboration and team efficiency:** Built to emulate the collaborative power of software version control systems, Workflow facilitates a shared environment where multiple users can track and contribute to different project stages.&#x20;

**Traceability and reproducibility:** In data science, the ability to reproduce results is critical. We designed the workflow to ensure that every step, from data import to model deployment, is documented and traceable, allowing for reproduction of experiments.&#x20;

**Customization and flexibility:** The workflow reflects the dynamic nature of machine learning projects, allowing for iterative changes and easy adaptation to new requirements, inspired by agile project management practices.

### With our workflow system you can:

* You can **track all steps** of data processing and model training, ensuring that experiments can be accurately reproduced with the same results.
* The workflow supports **version control** for both data and models, allowing you to track changes, manage modifications, and restore previous project states.
* All steps-from data upload to model prediction-are **visualized**, making it easier to understand the evolution of the project and models.
* Team members can easily track and interact with the workflow, making it easier to **work collaboratively** on projects.
* The workflow provides **quick access** **to various stages**, such as application sessions, files, and projects, for download or further work.

##

### **1. Data Collection and Preparation**

**Data Import**: Loading images or videos from various sources (cameras, databases, sensors) to be used for training the model.

**Data Preprocessing**: Includes processes like resizing images, normalizing brightness, and removing noise or artifacts that could hinder model training.

### **2. Data Annotation**

If the task requires labeled data (e.g., image classification or segmentation), the data is annotated: objects in the images are classified or annotated, either manually or using semi-automated tools.

### **3. Data Augmentation**

To increase the dataset size and improve model robustness, augmentation techniques are applied. These include transformations like rotations, scaling, flipping, brightness and contrast adjustments, and adding noise.

### **4. Neural Network Training**

Labeled and augmented data are fed into the neural network for training. The model undergoes multiple epochs where its parameters are optimized. **Checkpoints** (intermediate versions of the model) are saved periodically to allow for recovery or further refinement of the training process.

### **5. Model Evaluation**

After training, the model's performance is evaluated on test data. Metrics like accuracy, precision, recall, and F1-score are calculated to assess how well the model handles the task.

### **6. Image Filtering and Selection**

At this stage, data may be filtered to remove images that could negatively impact training, such as those with low resolution or highly similar images.

### **7. Model Deployment and Use**

The final trained model is deployed for real-world use. This could involve integrating the model into an application or system that processes images for tasks like object detection, classification, segmentation, or other types of visual analysis.

### **8. Model Maintenance and Updates**

As conditions change, new data becomes available, or performance improvements are needed, the model can be retrained or updated. The workflow remains flexible to adapt to new requirements.
