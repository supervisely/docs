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
  "docker_image": "supervisely/base-py-sdk:6",
  "headless": true,
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
  "docker_image": "supervisely/base-py-sdk:6",
  "headless": false,
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
- `"icon": "https://img.icons8.com/color/96/000000/console.png"` - icon URL
- `"icon_background": "#FFFFFF"` - icon background (we recommend to keep it white)


- `"task_location": "workspace_tasks"` - once you ran an app, the task is created. This field defines where the task will be shown: `"workspace_tasks"` or `"application_sessions"`. If your application applies to some item / or creates something in workspace (project / dataset / neural network / report/ ...) we recommend to use `"workspace_tasks"` to keep it at the same workspace, if your app uses items from different workspace or work with top-level items (team files, team members, labeling jobs, ...) we recommend to use `"application_sessions"` value.

Example for `"workspace_tasks"`: 

img here


Example for `"application_sessions"`: 

img here




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
