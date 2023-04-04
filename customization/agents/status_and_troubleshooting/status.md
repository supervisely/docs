Supervisely Agents have 3 possible statuses:

- **Running** - The agent has established a proper connection with the server and can perform tasks.
- **Waiting** - The agent is either not deployed or can't connect to the server.
- **Network Issue** - The connection between the agent and the server is unstable.

This information is available at the main Cluster page and on the individual agent pages.
![cluster](https://user-images.githubusercontent.com/48245050/227490463-e723ce70-1f02-4abe-b02b-3dd073cba87d.png)

Here are the troubleshoot guides for the most common issues causing the latter two statuses:

## Waiting
The agent is either not deployed or can't connect to the server.

In case the agent is not deployed, please follow the deployment guide [here](https://docs.supervise.ly/customization/agents/add_delete_node).

In case the agent can't connect to the server,  connect to the server via SSH and check the container logs.
```bash
docker ps -f name=agent
docker logs -f <container name or container id>
```

There might be various reasons causing this:
- Incorrect `SERVER_ADDRESS` - make sure that the address the agent is using for communication is reachable and correct.
- Page not found 404 - most likely caused by a 301 HTTP -> HTTPS redirect. Either change the SERVER_ADDRESS on the server or the SERVER_ADDRESS for the agent in the Start -> Team Cluster - Instructions -> Advanced settings
- ECONNREFUSED - check if you need to use an HTTP_PROXY/HTTPS_PROXY
- certificate verify failed - in case you're using a self-signed certificate you will need to combine your system CA certificates and your custom one and provide the path to the file in the advanced settings, CA cert section

## Network issue
To debug Supervisely NET client you can use the following command:
```bash
docker ps -f name=net-client
docker logs -f <container name or container id>
```

- Supervisely NET server is unreachable - make sure that the address and port are correct. Check your firewall settings so that it's not blocking the access
- subnet conflict - the default Supervisely NET subnet is 10.8.0.1/16. If the server where the agent is deployed has a conflicting subnet then you either need to change other subnets or change Supervisely NET subnet. This setting can only be configured on the Supervisely server itself.
