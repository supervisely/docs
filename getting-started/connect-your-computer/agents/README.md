A lot of tasks in Supervisely (like training neural networks or running DTL) require long and complex computations. Moreover, usually it's a good idea to distribute the work between several machines. 

Supervisely allows you to create a computational Cluster. Now users can connect their own computers or servers and use them to distribute tasks. It is as easy as making a few clicks and executing one shell command. 

So how does it work? Using [cluster page](add_delete_node/add_delete_node.md) you can generate unique command to run on your computer. It will start a new **Supervisely Agent** — a simple open-sourced tasks manager available as a Docker image. Agent will connect to Supervisely API and now you can run tasks on the connected computer — *host*.

Supervisely Computational Cluster can be scaled horizontally without any limits (All limits are defined by licensing agreement). Now users can add tens of nodes and perform hundreds of tasks in parallel. 

{% hint style="success" %}
This technology allows to organize and administrate a private data center inside the organization without any special knowledge. Now data scientists within the organization can easily share computational resources and perform multiple experiments simultaneously (NN training / inference, applying massive data augmentations and so on). 
{% endhint %}
