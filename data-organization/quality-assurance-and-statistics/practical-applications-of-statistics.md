---
description: >-
  Learn how to use best quality assurance and interactive statistical tools to
  perfect your custom training datasets and improve neural network performance.
---

# Practical applications of statistics

In this guide, we explore how to leverage best-in-class quality assurance and interactive statistical tools to improve the quality of your custom training datasets. These tools are crucial for identifying and rectifying data issues, such as class imbalances, annotation errors, and outliers, which can significantly impact the performance of neural network models. The guide includes practical applications of statistics, providing insights on data validation, anomaly detection, and optimizing the data acquisition process.

## Use Case 1: Missing or Misclassified Annotations

**Steps to solve using Class Balance and Image Statistics**

1.  **Class Balance Analysis**:

    Review the distribution of objects across different classes to identify any anomalies. Specifically, check the frequency of the "dog" class.

    Compare the total number of objects labeled as "dog" with the expected number based on the visual review.
2. **Per Image Statistics**:
   * **Detailed Image Review**: Use the per image statistics to find and analyze images containing the "dog" class. Verify the presence and correctness of the annotations.
   * **Anomaly Detection**: Look for images that either lack the annotated object or where the annotation is incorrect (e.g., wrong bounding box placement). Sorting images by the number of objects or area covered can help identify these discrepancies.
3. **Correction and Feedback**:
   * **Document Errors**: Use the information from the tables to document specific cases of misclassification or missing annotations.
   * **Feedback Loop**: Provide feedback to the data annotation team for corrections and improve future annotations.
4. **Updating Annotations**:
   * **Correct the Dataset**: Based on the identified issues, update the annotations to accurately reflect the objects in the images.



