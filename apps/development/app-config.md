Apps with GUI or without GUI (headless) have similar configs with little differences. Let's consider both examples, similarities and differences.  

Application without GUI (headless):
```json
{
  "type": "app",
  "name": "My Super App (with GUI)",
  "description": "short one-sentance description",
  "categories": ["a", "b", "c"],
  "icon": "https://img.icons8.com/color/96/000000/console.png",
  "icon_background": "#FFFFFF",
  "task_location": "workspace_tasks",
  "headless": true,
  "docker_image": "supervisely/base-py-sdk:6",
  "main_script": "src/my_super_script.py",
}
```


Application with GUI:
```json
{
  "type": "app",
  "name": "My Super App (with GUI)",
  "description": "short one-sentance description",
  "categories": ["a", "b", "c"],
  "icon": "https://img.icons8.com/color/96/000000/console.png",
  "icon_background": "#FFFFFF",
  "task_location": "workspace_tasks",
  "headless": false,
  "docker_image": "supervisely/base-py-sdk:6",
  "main_script": "src/my_super_script.py",
  "modal_template": "src/modal.html",
  "modal_template_state": {
    "samplePercent": 25
  },
  "gui_template": "src/gui.html",
}
```


Similarities (applicable to any app):
- `"type": "app"` - just keep it this way (other types will be relesed later)
- `"name": "My Super App (with GUI)"` - name of the app
- `"description": "short one-sentance description",` - description
- `"categories": ["a", "b", "c"],` - app can be assigned to multiple categories and will be listed in each of them
- `"headless": false,` - `true` or `false`.  



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
