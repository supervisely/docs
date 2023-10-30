# Labeling Guides & Exams

Creating large and diverse computer vision datasets requires working with a huge labeling workforce. That, in turn, requires professional tools to educate and examine them.

Why do we need **Labeling Guides** and **Labeling Exams**? Let’s consider several important observations:

- Usually, an annotator has concrete **domain specialization**: self-driving cars, agriculture, satellite imagery, medicine, and so on
- Not every annotator **properly understands** labeling requirements, thus sometimes they make **systematic errors** during labeling
- It is a good idea to choose for your custom task the most efficient and accurate labelers based on **Quality Score**
- From labelers perspective, comprehensive annotation policy should be presented as **easy to learn guides and materials**
- From time to time company changes annotation policy, all labelers have to be **notified and re-examined**

**Labeling Guides** and **Labeling Exams** in Supervisely are designed to handle all these aspects.

## Labeling Guides

Labeling Guides are videos, documents and markdown posts. You can pin here your annotation policy, examples of good and bad labeling and so on. Labeling Guides can later be attached to Labeling Jobs and Exams.

![](guides.png)


## Labeling Exams

Measure how labelers understand task. A manager sees the table with exams and their general information.

![](1_-uUIRN7qnlR2p5ueytmjQA.png)

The row can be expanded and the internal table with all labelers' attempts will be displayed. That table contains **Quality Scores** and links to **Exam Reports**.

![](1_q4GL28kGFIttvQNSj7jxRA.png)

This view allows to see the big picture and monitor the entire examination process. Also, it helps to dig into details and see how every labeler performs.

### Exam Report

Detailed error analysis at your fingertips. There are several tables with **geometry score**, **objects count score** and **tags score** to calculate more complete **Quality Score**. Also, there is a report table for every image with a bunch of statistics and calculated visual differences.

![](1_vGO5UbhrGzmkg42RB9lEzQ.png)

### Notifications for managers and reviewers

Notifications allow you to don’t miss relevant information and stay informed of what’s going on.

![](1_xBxNWaCoET2rz9WCafvbQg.png)
