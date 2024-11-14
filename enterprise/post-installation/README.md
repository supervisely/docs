# Post-installation

## Change the default password

We strongly recommend you to change the default password. To do it, please click on the user in the bottom left corner, click "Account settings" and navigate to "Change password".

<figure><img src="../../.gitbook/assets/Group 37.png" alt=""><figcaption></figcaption></figure>

## Create new users

By default we create two users: "admin" (to administrate the instance) and "supervisely" (to share demo projects and models in Explore).

We strongly advice you to keep admin account clean from models and projects and create separate teams and users for security reasons - if you would perform all the work in admin's team you may accidentally end up with overpopulated team with full access to everything.

<figure><img src="../../.gitbook/assets/Group 40.png" alt=""><figcaption></figcaption></figure>

Click on the "Members" in the bottom left corner. Here you can manage existing users, delete them, assign roles, login under their accounts and create new ones.

Click "Invite" to create a new user. We will automatically create a new team for that user and populate "Apps" section with default apps, marked as "Seed" (i.e. "Import / Images").

## Configure your instance

A good idea would be to check the "Instance Settings" page located in the admin's user menu. You will find tons of options you might like to configure, for example, enable HTTPS support or disable signup page:

<figure><img src="../../.gitbook/assets/Group 47.png" alt=""><figcaption></figcaption></figure>

### Server Configuration&#x20;

The **Server Configuration** section includes the necessary settings for the proper functioning of a server instance. The key components are:

* **Core Instance Settings** — Critical parameters required for the Supervisely instance. Edit with extreme caution, as incorrect values may bring the instance down, requiring manual `.env` file adjustments.
* [**Applications Autostart Settings**](./#configuring-automatic-launch-of-system-applications) — Configures the automatic start of applications on the instance, enabling required applications to launch automatically upon system startup.
* **Server Address** — The public or local network address of the server where Supervisely is deployed. This address must be accessible by the machines running agents. Note: `localhost` is not a valid option here.
* **Server Port** — The port used by Supervisely, with defaults of HTTP (80) and HTTPS (443) if HTTPS is configured. This can be changed if another application uses the same ports or if a reverse-proxy is configured. Ensure that ports 80 and 443 are enabled in the firewall or AWS security group.
* **CDN Domain** — The network address of the server where Supervisely stores data. It should be publicly accessible or accessible within the local network.
* **Data Folder** — The folder where Supervisely stores temporary and, if remote storage is not configured, permanent files. If this location is changed, existing files need to be moved to the new location. Avoid setting it to a network share (NFS or SMB), as this significantly impacts performance.
* **Disable Plugins** — A flag to disable plugins. The default is set to OFF.
* **Enable Apps Background Updates** — Enables background updates for applications. If disabled, applications are only updated when the instance itself is upgraded.
* **Public API Pagination Limit** — Sets the number of items returned by the Public API per page. The default value is 500.
* **Docker Compose Project** — The Docker Compose `COMPOSE_PROJECT_NAME` variable. Ensure it is unique across your server.
* **Postgres Memory** — The shared memory size allocated for Postgres.

#### Configuring automatic launch of system applications

To setup system applications to start automatically with the instance, you can add their configuration in the settings file. Use the following format:

```json
{
  // application slug
  "supervisely-ecosystem/render-previews-app": [
    // Each object in the array represents a separate session of the application
    {
      "isShared": true,                 // (optional) Default is false. If true, the application will be shared across the entire instance
      "nodeId": null,                   // Agent ID. You can specify a specific agent to run the application
      "skipVersionUpdates": false,      // (optional) Default is false. If true, disables automatic application restarts to newer versions
      "state": {}                       // (optional) Application launch parameters. You can pass settings here that are usually filled in the modal window during launch
    },
    {
      "nodeId": 1                       // Example of a second session of the same application
    }
  ]
}
```

**Field Explanations:**

* `isShared`: Makes the application accessible across the entire instance.
* `nodeId`: Specifies the agent ID for running the application. Leave it as `null` to assign a random agent.
* `skipVersionUpdates`: Disables automatic restart of the application to a newer version.
* `state`: Parameters for launching the application, similar to those filled out when launching through the interface.

**Example**

To add the "Render Previews" application with auto-launch and two sessions on the instance, use the following configuration:

```json
{
  "supervisely-ecosystem/render-previews-app": [
    {
      "isShared": true,
      "nodeId": null,
      "skipVersionUpdates": false,
      "state": {}
    },
    {
      "nodeId": 1
    }
  ]
}

```

***

Every kind of potentially long operation (like Import or Training) is performed on so-called [agents](../../getting-started/connect-your-computer/). Before you can use Supervisely, you should deploy at least one.

During the installation we automatically deploy a default "Main Node" agent via `supervisely deploy-agent` so you don't have to do anything. But, if you don't have a GPU device on your machine with Supervisely, you may want to deploy an additional agent on AWS or some computer with a videocard.

Go to "Cluster" page and click `Add agent`. Execute command from popup window on your server in terminal (you can use the same machine where Supervisely is deployed).

The status of deployed agent should change from "Waiting" to "Running". Now you can start using all features of Supervisely!

{% hint style="info" %}
Choose "Share with all users" from agent context menu if you want any user of your instance to perform tasks on it.
{% endhint %}

{% hint style="warning" %}
If you see at Cluster page that your Main Node is in Waiting status, it means that it could not be connected to Supervisely. Please check `SERVER_ADDRESS` variable in your `.env` file. Agent should be able to make outbound connections to that IP or Host. As a quick solution you can find your `docker0` ip address that act as `locahost` for Docker: run `ip addr list docker0` and use it in `SERVER_ADDRESS`. It should look like `172.17.0.1` or something. Run `supervisely deploy-agent` to apply your changes. Main Node at Cluster page should change status to "Running"
{% endhint %}

## Import your own dataset

Go to the Import page, make sure preset "Supervisely / Images" is selected and drag-and-drop a folder with some images. Enter a name for the new project, wait till the files are uploaded and click "Import". New import task has been started and you will see your new project on the Projects page after it's finished.

{% hint style="warning" %}
If you see message like above at Import page, there could be two reasons: 1). You are logged-in as "admin" user. We do not automatically add any apps to admin team. You can do it manually from Explore section, but we suggest to create new user instead. 2). Another reason is that you don't have active agents at Cluster page. Check "Main Node is in Waiting status" section above.
{% endhint %}
