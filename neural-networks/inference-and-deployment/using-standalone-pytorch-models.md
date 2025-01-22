This method completely decouple you from both Supervisely Platform and Supervisely SDK, and you will develop your own code for inference and deployment. It's also important to understand that for each neural network and framework, you'll need to set up an environment and write inference code by yourself, since each model has its own installation instructions, and the format of inputs and outputs. But, in many cases, we provide our examples of using the model as a standalone PyTorch model. You can find our guidelines on a GitHub repository of the corresponding model. For example, [RT-DETRv2 Demo](https://github.com/supervisely-ecosystem/RT-DETRv2/tree/main/supervisely_integration/demo#readme).


## Quick start *(RT-DETRv2 example)*:

1. **Download** your checkpoint and model files from Team Files.

2. **Clone** our [RT-DETRv2](https://github.com/supervisely-ecosystem/RT-DETRv2) fork with the model implementation. Alternatively, you can use the original [RT-DETRv2](https://github.com/lyuwenyu/RT-DETR/tree/0b6972de10bc968045aba776ec1a60efea476165) repository, but you may face some unexpected issues if the authors have updated the code.

```bash
git clone https://github.com/supervisely-ecosystem/RT-DETRv2
cd RT-DETRv2
```

3. **Set up environment:** Install [requirements](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/rtdetrv2_pytorch/requirements.txt) manually, or use our pre-built docker image ([DockerHub](https://hub.docker.com/r/supervisely/rt-detrv2/tags) | [Dockerfile](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/docker/Dockerfile)).

```bash
pip install -r rtdetrv2_pytorch/requirements.txt
```

4. **Run inference:** Refer to our example scripts of how to load RT-DETRv2 and get predictions:

- [demo_pytorch.py](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/supervisely_integration/demo/demo_pytorch.py)
- [demo_onnx.py](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/supervisely_integration/demo/demo_onnx.py)
- [demo_tensorrt.py](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/supervisely_integration/demo/demo_tensorrt.py)

**demo_pytorch.py** is a simple example of how to load a PyTorch checkpoint and get predictions. You can use it as a starting point for your own code:

```python
import json
from PIL import Image, ImageDraw
import torch
import torchvision.transforms as T
from rtdetrv2_pytorch.src.core import YAMLConfig


device = "cuda" if torch.cuda.is_available() else "cpu"

# put your files here
checkpoint_path = "model/best.pth"
config_path = "model/model_config.yml"
model_meta_path = "model/model_meta.json"
image_path = "img/coco_sample.jpg"


def draw(images, labels, boxes, scores, classes, thrh = 0.5):
    for i, im in enumerate(images):
        draw = ImageDraw.Draw(im)
        scr = scores[i]
        lab = labels[i][scr > thrh]
        box = boxes[i][scr > thrh]
        scrs = scores[i][scr > thrh]
        for j,b in enumerate(box):
            draw.rectangle(list(b), outline='red',)
            draw.text((b[0], b[1]), text=f"{classes[lab[j].item()]} {round(scrs[j].item(),2)}", fill='blue', )


if __name__ == "__main__":

    # load class names
    with open(model_meta_path, "r") as f:
        model_meta = json.load(f)
    classes = [c["title"] for c in model_meta["classes"]]

    # load model
    cfg = YAMLConfig(config_path, resume=checkpoint_path)
    checkpoint = torch.load(checkpoint_path, map_location="cpu")
    state = checkpoint["ema"]["module"] if "ema" in checkpoint else checkpoint["model"]
    model = cfg.model
    model.load_state_dict(state)
    model.deploy().to(device)
    postprocessor = cfg.postprocessor.deploy().to(device)
    h, w = 640, 640
    transforms = T.Compose([
        T.Resize((h, w)),
        T.ToTensor(),
    ])

    # prepare image
    im_pil = Image.open(image_path).convert('RGB')
    w, h = im_pil.size
    orig_size = torch.tensor([w, h])[None].to(device)
    im_data = transforms(im_pil)[None].to(device)

    # inference
    output = model(im_data)
    labels, boxes, scores = postprocessor(output, orig_size)

    # save result
    draw([im_pil], labels, boxes, scores, classes)
    im_pil.save("result.jpg")
```