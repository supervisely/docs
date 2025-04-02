# Prediction API

Suppose you've trained a new model in Supervisely and want to deploy it for inference. You can do this with ease using the new **Supervisely Prediction API**.

First, you need to deploy the model or connect to an existing one.

## Connect and Deploy

{% tabs %}
{% tab title="Deploy model" %}
```python
import supervisely as sly

api = sly.Api()

model = api.nn.deploy_custom_model(
    checkpoint_id=12345,  # file id of checkpoint in Team Files
)
```
{% endtab %}
{% tab title="Connect to existed model" %}
```python
import supervisely as sly

api = sly.Api()

model = api.nn.connect(
    task_id=12345,  # Task ID of a running app in Supervisely
)
```
{% endtab %}
{% endtabs %}

## Predict

After you've connected to the model, you can use it to make predictions. The model can accept various input formats, including images, paths, and URLs.

{% tabs %}

{% tab title="image" %}
```python
prediction = model.predict(
    input="path/to/image.jpg",
)
```
{% endtab %}

{% tab title="PIL.Image" %}
```python
from PIL import Image

image = Image.open("path/to/image.jpg")
prediction = model.predict(
    input=image,
)
```
{% endtab %}

{% tab title="URL" %}
```python
prediction = model.predict(
    input="https://example.com/image.jpg",
)
```
{% endtab %}

{% tab title="numpy" %}
```python
import numpy as np

image_np = np.random.randint(low=0, high=255, size=(640, 640, 3), dtype="uint8")

prediction = model.predict(
    input=image_np,
)
```
{% endtab %}

{% tab title="list" %}
```python
prediction = model.predict(
    input=["image1.jpg", "image2.jpg"],
)
```
{% endtab %}

{% endtabs %}