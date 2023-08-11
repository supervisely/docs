---
description: >-
  Everything you need to know about deploying Supervisely agent on Unix-based
  operating systems
---

# Unix-based

This guide aims to lead you through the step-by-step process for establishing and configuring the Supervisely agent within your unix-based operating system environment.

{% embed url="https://www.youtube.com/watch?v=aO7Zc4kTrVg" %}
Video guide
{% endembed %}

## Prerequisites

* Unix-based OS (Linux, MacOS)
* [Docker](https://docs.docker.com/engine/install/) (Version 18.0 or higher)
* [CUDA](https://developer.nvidia.com/cuda-downloads) (Version 9.0 or higher)
* [NVIDIA Docker](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

![Requirements](team-cluster-modal.png)

**Make sure that the computer you want to use in Supervisely meets the above requirements.**

## Deploy Supervisely Agent

Deploy Supervisely Agent with GPU support on Linux.

Open Supervisely instance and go to the Start -> Team Cluster page and press "Add" button

![Add Agent](supervisely-agent-add.png)

Select "Supervisely agent".

![Select Agent](supervisely-agent-select.png)

In the modal window go to "advanced settings" and check "Use nvidia runtime" option to enable GPU support.

![Agent Settings](supervisely-agent-settings.png)

Copy the command to the terminal and run it.

![Terminal](linux-terminal-start.png)

Wait until the Docker image is pulled and you see the message: "You can close this terminal safely now".

![Terminal Bash](linux-terminal-finish.png)

That's it! Now your agent is deployed and running.
