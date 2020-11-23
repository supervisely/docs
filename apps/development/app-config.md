Apps with GUI or without GUI (headless) have similar configs with little differences. Let's consider both examples, similarities and differences.  

Application without GUI (headless):
```json
{
  "type": "app",
  "name": "My Super App (without GUI)",
  "categories": [
    "a",
    "b",
    "c"
  ],
  "description": "short one-sentance description",
  "headless": true,
  "task_location": "workspace_tasks",
  "icon": "https://img.icons8.com/color/96/000000/console.png",
  "icon_background": "#FFFFFF",
  "docker_image": "supervisely/base-py-sdk:6",
  "main_script": "src/my_super_script.py",
}
```


Application with GUI:
```json
{
  "type": "app",
  "name": "My Super App (with GUI)",
  "categories": [
    "a",
    "b",
    "c"
  ],
  "description": "short one-sentance description",
  "headless": false,
  "task_location": "workspace_tasks",
  "icon": "https://img.icons8.com/color/96/000000/console.png",
  "icon_background": "#FFFFFF",
  "docker_image": "supervisely/base-py-sdk:6",
  "main_script": "src/my_super_script.py",
  "modal_template": "src/modal.html",
  "modal_template_state": {
    "samplePercent": 25
  },
  "gui_template": "src/gui.html",
}
```




## Additional settings (advanced usage):
```json
"context_menu": {
    "target": ["images_project", "images_dataset"],
    "context_root": "Report"
},
```

TODO: explain later:
`need_gpu`
`integrated_into`
