# DTL

Data preparation for training takes most of data scientists's time. In addition, there is a high probability of mistakes while performing such process.

We designed a special language that allows to fully automate data manipulation: merge projects and datasets, make classes mapping, various augmentations of images and annotations, save to different formats and more.

This process is defined with a JSON based config file. More technically, it is an array of objects where each object defines one transformation.

When we design a neural network we think about it in terms of computational graph. This is the core abstraction behind popular deep learning frameworks. Computational graph consists of math operations and variables.

We developed the powerful DTL that opens up the possibility of configuring data manipulation with computational graphs. We can define the sequence of operations that will be applied to each image from the selected datasets.

Let me show you a small example to demonstrate the concept:

```json
[
  {
    "action": "data",
    "src": [
      "my_project/*"
    ],
    "dst": "$data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "flip",
    "src": [
      "$data"
    ],
    "dst": "$data_flip",
    "settings": {
      "axis": "vertical"
    }
  },
  {
    "action": "supervisely",
    "src": [
      "$data",
      "$data_flip"
    ],
    "dst": "result_project",
    "settings": {
    }
  }
]
```

Here you can see an array of objects. An object is a "Layer" that performs an operation with data (image + annotation). We can make a sequence of such layers to define the whole process of data transformation.

Every layer is a JSON-object in the following format:

```json
{
  "action": "...",
  "src": "...",
  "dst": "...",
  "settings": {}
}
```

Fields description:

* `action` — defines the type of operation. For example: `"action": "flip"` means that every image that is fed to this layer will be flipped.
* `src` — input data
* `dst` — output data
* `settings` — transformation settings

Here is the graphical representation of the computational graph from the example:

![](../../assets/legacy/all\_images/exp\_001.png)

The first layer from the example is data layer. It takes all images with their annotations from all datasets in the project `my_project`. Then this data is fed to the flip layer. The flip layer produces the flipped versions of images and annotations. The last layer ( `"action": "supervisely"`) creates a new project `result_project` and saves the input data (original + flipped).

### Placeholders

As you can see from the example, we use values like `$data` or `$data_flip` in fields `src` and `dst`. Don't worry if you haven't seen them before — we haven't either. These are just temporal names for variables (aka _placeholders_). You can choose any name you want. It has to start with the symbol `$`.

The only exceptions are Data and Save layers: some of these layers use fields `src` and `dst` as the name of an input project or an output directory.

### How to run Data Transformation in Supervisely

Click "DTL" in the left menu. Write a json configuration in the edit widget and then click the "Start" button. You will be automatically moved to the "Tasks" tab where you can see the progress and logs, stop task, download the final archive or go to the generated project.

![](<intro/ui (1).png>)

Primary controls:

1. Saved configurations. You can save the current configuration by selecting the "New config..." option from the dropdown menu and giving it a name. You can later select it from the dropdown menu to load the saved configuration into your editor, update it or remove.
2. Agent selection.
3. "Start" button
4. The graphical representation of the config. You can download it as an `.svg` file by clicking the top right icon. Also you can zoom and shift it with the mouse. If you will click on the purple node (any action), you will be automatically redirected to its json-object in the configuation.
