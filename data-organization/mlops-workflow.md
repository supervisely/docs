---
hidden: true
---

# MLOps Workflow

A workflow on a computer vision and machine learning platform like Supervisely is the sequence of actions and tools applied to data at each stage of a project. It shows how data has been transformed and used for model training. Key elements of a workflow include:

* **Traceability and reproducibility:** You can track all steps of data processing and model training, ensuring that experiments can be accurately reproduced with the same results.
* **Version Control:** The workflow supports version control for both data and models, allowing you to track changes, manage modifications, and restore previous project states.
* **Project Management:** All steps-from data upload to model prediction-are visualized, making it easier to understand the evolution of the project and models.
* **Collaboration:** Team members can easily track and interact with the workflow, making it easier to work collaboratively on projects.
* **Easy navigation:** The workflow provides quick access to various stages, such as application sessions, files, and projects, for download or further work.

## The main steps of workflow in computer vision

### **1. Data Collection and Preparation**

* **Data Import**: Loading images or videos from various sources (cameras, databases, sensors) to be used for training the model.
* **Data Preprocessing**: Includes processes like resizing images, normalizing brightness, and removing noise or artifacts that could hinder model training.

### **2. Data Annotation**

* If the task requires labeled data (e.g., image classification or segmentation), the data is annotated: objects in the images are classified or annotated, either manually or using semi-automated tools.

### **3. Data Augmentation**

* To increase the dataset size and improve model robustness, augmentation techniques are applied. These include transformations like rotations, scaling, flipping, brightness and contrast adjustments, and adding noise.

### **4. Neural Network Training**

* Labeled and augmented data are fed into the neural network for training. The model undergoes multiple epochs where its parameters are optimized. **Checkpoints** (intermediate versions of the model) are saved periodically to allow for recovery or further refinement of the training process.

### **5. Model Evaluation**

* After training, the model's performance is evaluated on test data. Metrics like accuracy, precision, recall, and F1-score are calculated to assess how well the model handles the task.

### **6. Image Filtering and Selection**

* At this stage, data may be filtered to remove images that could negatively impact training, such as those with low resolution or highly similar images.

### **7. Model Deployment and Use**

* The final trained model is deployed for real-world use. This could involve integrating the model into an application or system that processes images for tasks like object detection, classification, segmentation, or other types of visual analysis.

### **8. Model Maintenance and Updates**

* As conditions change, new data becomes available, or performance improvements are needed, the model can be retrained or updated. The workflow remains flexible to adapt to new requirements.
