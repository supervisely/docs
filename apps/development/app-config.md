```json
{
  "name": "Classes stats for images",
  "type": "app",
  "categories": [
    "report",
    "images",
    "data exploration"
  ],
  "description": "Detailed statistics for all classes in images project",
  "docker_image": "supervisely/base-py-sdk:6",
  "main_script": "src/classes_stats_for_images.py",
  "modal_template": "src/modal.html",
  "modal_template_state": {
    "samplePercent": 25
  },
  "gui_template": "src/gui.html",
  "task_location": "workspace_tasks",
  "isolate": true,
  "context_menu": {
    "target": ["images_project", "images_dataset"],
    "context_root": "Report"
  },
  "icon": "https://img.icons8.com/fluent/96/000000/combo-chart.png",
  "icon_background": "#FFFFFF"
}
```

```json
{
  "name": "App Template (No GUI)",
  "type": "app",
  "categories": [
    "development"
  ],
  "description": "template for your headless app",
  "docker_image": "supervisely/base-py-sdk:6",
  "main_script": "src/my_super_script.py",
  "task_location": "workspace_tasks",
  "isolate": true,
  "icon": "https://img.icons8.com/color/96/000000/console.png",
  "icon_background": "#FFFFFF",
  "headless": true
}
```

```json
{
  "type": "app",
  "name": "My Super App",
  "description": "short description here",
  "categories": [
    "stats",
    "semantic segmentation"
  ],
  "docker_image": "supervisely/base-py-sdk:6",
  "main_script": "src/my_super_script.py",
  "task_location": "workspace_tasks",
  "icon": "https://img.icons8.com/color/96/000000/console.png",
  "icon_background": "#FFFFFF",
  "headless": true,???????
  "modal_template": "src/modal.html",
  "modal_template_state": {
    "samplePercent": 25
  },
  "gui_template": "src/gui.html",
  "context_menu": {
    "target": ["images_project", "images_dataset"],
    "context_root": "Report"
  },
}
```

- `"type": "app"` - defines application type


