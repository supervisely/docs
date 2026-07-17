# Hardened Docker Images

Supervisely Apps run on Agents inside Docker containers. Hardened Docker images are new runtime images for Supervisely Apps.

Instead of using large shared images with many unused dependencies, each app is now built and distributed with only the runtime components it actually needs.

{% hint style="info" %}
From the user side, nothing changes in the UI: you still click **Run App** as usual.
{% endhint %}

## Why this is useful

Hardened Docker images give several practical benefits:

* **Lighter app images.** In many cases images become 5-10x smaller, which means faster pulls on Agents and less disk space used for cached images.
* **Only required dependencies are installed.** The image does not include a large set of shared requirements that are not used by the app.
* **Images are distributed per application.** Each app has its own image instead of using one large shared base image with many unused dependencies in most cases.
* **Newer Python versions.** Hardened images use modern Python versions compared to the older Python 3.8 runtime used by many legacy images.
* **Smaller attack surface.** The final runtime does not include package managers, build tools, and other utilities that are not needed to run the app.
* **Better support for GPU apps.** Training, inference, serving, and tracking apps can use a dedicated hardened CUDA runtime.

## How it works

The flow is the following:

1. App dependencies are declared in the repository, and the Docker image tag is defined in `config.json`.
2. A shared GitHub Actions workflow builds the app image from a reusable Docker template.
3. In the **builder stage**, Python dependencies are converted into wheels in an isolated environment.
4. In the **runtime stage**, Supervisely starts from one of the hardened base images:
   * `supervisely/base-py-sdk-hardened` for regular CPU apps
   * `supervisely/base-py-cuda-hardened` for GPU, training, serving, and tracking apps
   * Sometimes, a custom docker template is defined for specific apps
5. The prebuilt wheels are installed inside the runtime image.
6. Build-only tools and unnecessary files are removed from the final image.
7. The image is pushed to the registry.
8. The Agent pulls this final image and runs the app task in the usual way.

This means the image that reaches the Agent is already prepared for execution.

## What makes the runtime "hardened"

Compared to a typical all-in-one Docker image, the hardened runtime is smaller and more focused:

* Python dependencies are built before the runtime image is assembled.
* The final image removes `pip`, `setuptools`, `wheel`, `pkg_resources`, and related build helpers when they are not needed at runtime.
* System package managers and download tools such as `apt`, `apt-get`, `git`, `curl`, and `wget` are removed from the runtime base image.
* Temporary files, caches, bytecode, and test directories are cleaned up.

This approach keeps the final runtime focused on one job: running the app.

## CPU and GPU variants

Supervisely currently uses two main hardened runtime families:

| Runtime image | Typical use cases |
| --- | --- |
| `base-py-sdk-hardened` | Import/export apps, data tools, automation, reporting, UI utilities, and other CPU workloads |
| `base-py-cuda-hardened` | Neural network training, inference, serving, tracking, and other GPU workloads |

The GPU variant extends the hardened SDK runtime with curated CUDA runtime libraries, so GPU apps can target a standard environment instead of bundling their own CUDA runtime from scratch.

## What users will notice

Users will mostly notice operational improvements:

* Images are pulled faster.
* Less disk space is used on the Agent.
* Apps no longer carry many unused shared dependencies.

The application interface and the way users launch tasks stay the same.

## What this means for private app developers

If you build custom Supervisely Apps, hardened images give a recommended packaging model:

* Choose the CPU or GPU hardened base image depending on the real workload.
* Put runtime dependencies into the app requirements file and build them into the image before publishing.

{% hint style="warning" %}
Hardened runtimes intentionally remove package managers and build tooling from the final image. If an app tries to install packages at runtime, it should be redesigned to include those dependencies during the image build instead.
{% endhint %}

## Related pages

* [How agents work](../agent/agent.md)
* [Integration with Docker](../custom-docker-registry/README.md)
* [Private Apps](../../enterprise/private-apps/README.md)
