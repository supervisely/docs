---
description: >-
  Everything you need to know about deploying Supervisely agent on Linux based
  operating systems
---

# Deploy Supervisely agent on Linux

Supervisely agent can work both with and without GPU support. If you don't have a GPU, you can deploy the agent on any machine with Linux OS and you can skip the GPU installation steps.
This tutorial explains how to deploy the Supervisely agent on Linux OS.

## Table of Contents

- [Prerequisites](./unix-based.md#prerequisites)
- [How to install](./unix-based.md#how-to-install)
- [Step 1: Install Docker](./unix-based.md#step-1-install-docker)
- [Step 2: Install CUDA Toolkit](./unix-based.md#step-2-install-cuda-toolkit)
- [Step 3: Install NVIDIA Driver](./unix-based.md#step-3-install-nvidia-driver)
- [Step 4: Install NVIDIA Container Toolkit](./unix-based.md#step-4-install-nvidia-container-toolkit)
- [Step 5: Deploy Supervisely Agent](./unix-based.md#step-5-deploy-supervisely-agent)
- [Troubleshooting](./unix-based.md#troubleshooting)

## Prerequisites

The agent is shipped as a Docker image built on top of CUDA 12.8 (`nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04`). The agent itself only reads GPU information via the host driver (NVML / `nvidia-smi`), so it starts on a wide range of driver versions. However, the GPU applications that the agent launches in separate containers are built against newer CUDA versions, so the host driver determines whether those workloads run reliably.

For this reason there are two tiers of requirements — the **minimum** needed for the agent to run, and the **recommended** setup for stable execution of GPU applications:

| Component                                                                                                               | Minimum required       | Recommended (stable)      |
| ----------------------------------------------------------------------------------------------------------------------- | ---------------------- | ------------------------- |
| Linux OS                                                                                                                | Kernel 5.15 or higher  | Ubuntu 24.04 LTS or later |
| [Docker](https://docs.docker.com/engine/install/ubuntu/)                                                                | 19.03 or higher        | Latest stable             |
| [NVIDIA Driver](https://developer.nvidia.com/cuda-downloads)                                                            | 535 (CUDA 12.2 branch) | **570.26 or higher**      |
| [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads)                                                             | 12.2                   | **12.8**                  |
| [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) | Any recent version     | Latest                    |

> **Why the difference?** CUDA 12.8 workloads run **natively** on driver **≥ 570.26**. On older drivers — down to the **535 branch (CUDA 12.2)** — they run via the [CUDA forward-compatibility package](https://docs.nvidia.com/deploy/cuda-compatibility/latest/forward-compatibility.html) (`cuda-compat-12-8`), whose lowest supported base branch is 535. Below 535 there is no supported path for CUDA 12.8. Forward compatibility is officially supported on **NVIDIA Data Center GPUs**; on other GPUs (e.g. GeForce) install driver **570.26 or higher**, which removes the need for the compat package and avoids edge cases (PTX JIT from a newer toolkit, the newest GPU architectures such as Blackwell, features introduced after the installed driver branch).
>
> **CPU-only machines** don't need any of the NVIDIA components — you can skip the driver, CUDA Toolkit, and Container Toolkit steps below.

## How to install

All commands assume Ubuntu 24.04 on an `x86_64` host; notes throughout point out where to adjust for Ubuntu 22.04. Run them as a user with `sudo` privileges, and reboot when prompted after the driver installation.

### Step 1: Install Docker

First, set up the Docker apt repository:

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Then install the Docker packages:

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Finally, verify that the Docker Engine installation is successful by running the hello-world image:

```bash
 sudo docker run hello-world
```

Check out the official [Docker documentation](https://docs.docker.com/engine/install/ubuntu/) for more information.

### Step 2: Install CUDA Toolkit

Install the CUDA Toolkit 12.8 using the local installer:

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin
sudo mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-ubuntu2404-12-8-local_12.8.0-570.86.10-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2404-12-8-local_12.8.0-570.86.10-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2404-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8
```

> The commands target **Ubuntu 24.04**. If your host runs Ubuntu 22.04, replace `ubuntu2404` with `ubuntu2204` in both URLs — CUDA 12.8 and driver 570 are available for both. For a different patch release, find the matching `.deb` on the [official downloads page](https://developer.nvidia.com/cuda-downloads).

<details>

<summary>Online installation (network repository)</summary>

If the host has direct internet access, the network repository is simpler and keeps the toolkit updated via `apt`:

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8
```

</details>

<details>

<summary>Legacy installation (CUDA 12.4, minimum supported)</summary>

CUDA 12.4 is still supported as a minimum, but CUDA 12.8 above is recommended.

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda-repo-ubuntu2204-12-4-local_12.4.1-550.54.15-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-4-local_12.4.1-550.54.15-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-4-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-4
```

</details>

Check out the official [CUDA Toolkit documentation](https://developer.nvidia.com/cuda-downloads) for more information and the latest version.

### Step 3: Install NVIDIA Driver

Install the NVIDIA driver using the following commands:

```bash
sudo apt-get install -y cuda-drivers-570
```

<details>

<summary>Legacy driver (550, minimum supported)</summary>

Driver 550 is the minimum that pairs with CUDA 12.4. It still works for CUDA 12.8 workloads via the forward-compatibility package, but driver 570 above is recommended.

```bash
sudo apt-get install -y cuda-drivers-550
```

</details>

To verify the installation, run the following command:

```bash
nvidia-smi
```

It's recommended to restart your system after installing the NVIDIA driver with the following command:

```bash
sudo reboot
```

The output should display the NVIDIA driver version, CUDA version, and GPU information.

![nvidia-smi](https://github.com/supervisely/developer-portal/assets/118521851/0816dc4f-8ac7-4a80-b4c0-09652a7f21d9)

If you can see this information, the installation was successful. Otherwise, please check the [Troubleshooting](unix-based.md#troubleshooting) section.

Check out the official [NVIDIA Driver documentation](https://developer.nvidia.com/cuda-downloads) for more information and the latest version.

### Step 4: Install NVIDIA Container Toolkit

The NVIDIA drivers must be also available in the Docker containers, so the agent can utilize the GPU. To do this, install the NVIDIA Container Toolkit using the following commands:

```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
```

Now, configure the Docker daemon to use the NVIDIA runtime:

```bash
sudo nvidia-ctk runtime configure --runtime=docker
```

Finally, restart the Docker daemon:

```bash
sudo systemctl restart docker
```

Now, we'll need to ensure that the NVIDIA Container Toolkit is installed and working correctly and that the NVIDIA runtime is available inside the Docker containers. To do this, run the following command:

```bash
sudo docker run --rm --runtime=nvidia --gpus all nvidia/cuda:12.8.1-base-ubuntu24.04 nvidia-smi
```

The output should display the NVIDIA driver version, CUDA version, and GPU information.

![nvidia-smi in Docker](https://github.com/supervisely/developer-portal/assets/118521851/d117b3f3-2d59-4fa7-a735-37edc8f49804)

If you can't see this information, please check the [Troubleshooting](unix-based.md#troubleshooting) section.

### Step 5: Deploy Supervisely Agent

Now it's time to deploy the Supervisely agent.

Open Supervisely instance, go to the Cluster page and press the `Add` button. Select the `Supervisely agent` option.

![Add Agent](https://github.com/supervisely/developer-portal/assets/118521851/4b9942ba-8a5c-4909-a6c1-c1a81defefe6)

Copy the command and run it in the terminal on the machine where you want to deploy the agent.

![Command](https://github.com/supervisely/developer-portal/assets/118521851/b3206a8a-cae8-4930-9cb0-f0214ba04324)

That's it! Now your agent is deployed and running.

### Troubleshooting

If the `nvidia-smi` command does not display the GPU information from OS or the Docker container, the NVIDIA drivers were not successfully installed.
In this case, you can try to uninstall the NVIDIA drivers and CUDA Toolkit:

```bash
sudo apt-get purge nvidia*
sudo apt-get purge cuda*
sudo apt-get autoremove
sudo apt-get autoclean
```

After that restart your system, and try to install the components again.
