Here you can find all the necessary information about adding (or deleting) nodes to your computational Cluster. 

With the Supervisely Agent it is easy and straightforward to add new nodes to the Cluster.

{% hint style="info" %}
We only run the tasks that you have explicitly started yourself on your agents. We will never use your nodes for benefit of others.
{% endhint %}

## System requirements

First, make sure that the computer you want to use in Supervisely meets the following requirements:

- Linux OS (Kernel 3.10)
- Docker (Version 18.0)
- GPU (CUDA 9.0) - for training and inference tasks
- Nvidia-docker - for training and inference tasks

## Installation

### Video Guide
To connect the agent you can follow the steps as they described in the following video guide:


https://github.com/supervisely/docs/assets/48245050/832ae03d-58d4-4abb-9e8c-307ca8f4b072

 

### Installation Instructions
Open the Cluster section in Supervisely Dashboard. If you have no agents installed yet, you will see the following:

![](01.png)

Click "Connect your first node" button to open the Agent installation dialog window.



![](agent_a.png)

Copy the command you will see (you can click on the blue icon on the right to do it), paste it in the terminal on the computer (host) you want to use with Supervisely and run it.

{% hint style="info" %}
You can run only one agent per node. Don't worry — it's multithreading and runs tasks in separate docker containers.
{% endhint %}

It will run the Supervisely *agent* as a docker image with name "supervisely-agent/<token>".

### Advanced configuration (optional)

Before starting the Agent on you computer you can customize a few parameters.

![](agent_adv_a.png)

{% hint style="info" %}
To apply changes in advanced settings to an already running agent you need to copy the resulting command and execute it on the same machine where the agent is currently running
{% endhint %}

- Use nvidia runtime: will add `--runtime-nvidia` flag to docker run to support GPU related taks
- Registries: if you want to use your own private docker images for training and inference custom models, provide path, login and password.

  
{% hint style="info" %}
We don't store your registry credentials. Your login and password will be passed to command as environment variables.
{% endhint %}

You should see the the following output in your terminal:

![](../../../assets/legacy/cluster/cmd.jpg)

You can now close the terminal window.

{% hint style="info" %}
Supervisely agent runs with a `--restart=always` flag by default and will start again after reboot.
{% endhint %}

## Restarting and updating the agent

There are a few scenarios when you will need to restart an Agent: to update to the latest version or to apply your custom changes. The restart process is simple. 

![](agent_instr_a.png)

Just click the "three dots" icon in the nodes list and select "Instructions". Copy the command from the instructions and run it in the terminal on the Agent's computer (host). The updated version will be automatically pulled from the Docker registry.

{% hint style="warning" %}
Restarting agent will stop all running tasks
{% endhint %}

## Disable agent

To remove the node from Supervisely simply click on the "three dots" icon in the nodes list and select "Archive". You data will stay safe and you can recover you node later by selecting the "Recover" option. 

![](agent_dis_a.png)

## Stop agent(s)

If you need to stop your agent(s), you can safely do it by running the `docker stop $(docker ps -q -f "name=supervisely-agent")` command in your terminal. You can always bring it back by running `docker start $(docker ps -q -f "name=supervisely-agent")` command. The agent will re-connect to Supervisely and you will be able to continue your work.

## Remove agent(s)

To completely remove agent(s) from your machine run `docker rm -fv $(docker ps -q -f "name=supervisely-agent")` in your terminal and delete directory `~/.supervisely-agent/<token>`



