# Application Directory Structure

Let's consider the following example: [Hello World App](https://github.com/supervisely-ecosystem/hello-world-app). It has the following directory structure:

```
.
├── README.md
├── config.json
├── debug.env
├── secret_debug_example.env
└── src
    ├── gui.html
    ├── modal.html
    └── my_main_script.py
```

- `README.md` - file that explains how to use application
- `config.json` - JSON file defines: icon, title, short description, categories in ecosystem, context menu, ...
- `debug.env`, `secret_debug_example.env` (optional) - files used only for debug and development process
- `src/gui.html` (optional) - defines UI
- `src/modal.html` (optional) - defines modal window UI. It appears before application start, allows to choose: agent that will host app, app version and allows to setup input parameters for app before start.
- `src/my_main_script.py` - entrypoint (main) script. There are no special requirements on how to organize source files: you can have a single python files or multiple files in arbitrary structure. The only one requirement: is to defile the path of entrypoint python script in the `config.json` file.
