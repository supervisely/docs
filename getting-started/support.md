1. Understand what issue user has:
- With some application -> how to download logs from the app session
- Inside of the UI of the platform (error) -> Enterprise or Community (saas)?
- Not error, but platform works slow? -> EE or CE? Connection speed?
- Not error, but weird behavior? -> EE or CE? Logs?

# Supervisely Support

Whether you're using our Community Edition or Enterprise Edition, this page is your starting point for getting help, and resolving issues quickly. If you need immediate assistance, please reach out to our support team.  
**Email:** support@supervisely.com  
**Community Edition Slack:** [Join here](https://supervisely.com/slack)  
**Enterprise Edition Slack:**  for our Enterprise customers, we typically set up a private Slack channel for faster, real-time support. If you're an Enterprise user and not yet a member of your dedicated Slack channel, just let us know and we’ll get you added right away.

## Community Edition or Enterprise Edition?

Not sure what edition you're using? No worries—we’ve got you covered.

- If you open Supervisely at `https://app.supervisely.com`, you're using the **Community Edition**.
- If you're accessing it through any other address, you're on the **Enterprise Edition**.

Enterprise users receive **high-priority support**—you can reach out to us directly, and we’ll do our best to resolve your issue as soon as possible.  
If you're contacting us from a personal email address, please mention that you're an Enterprise user to help us prioritize your request.

### Cloud-hosted Enterprise Instances

If your Supervisely server address ends with `enterprise.supervisely.com`, you're using an **Enterprise instance hosted in our Cloud**.  
This means the Supervisely team is actively managing the server, including updates, backups, maintenance, logs, and troubleshooting. You **do not need to collect or send a troubleshooting archive**, just contact us directly, and we’ll take it from there.

## I have a question

...

## I Have an Issue

If something’s not working as expected in Supervisely, let’s first narrow down what kind of issue you're facing:

1. You're having [trouble with an app from the Supervisely Ecosystem](#issues-with-applications) (or a custom app).  
2. You see an error message in the UI outside of the app (e.g. "Something went wrong").  
3. The platform isn’t throwing errors, but it feels slow or laggy.  
4. Things technically work, but the behavior seems off or unexpected.  
5. You're running into a technical issue with the API or SDK.  
6. You're an Enterprise technical engineer and need help with deployment.  

Once you’ve identified the type of issue, scroll down to find the best way to get support.

### Issues with Applications

If you're having trouble with an app from the Supervisely Ecosystem (or a custom app), here are some steps you can take:

1. Check the app's README section and ensure that you followed all setup instructions.  
2. If there are some specific error messages while running the app, please download its logs and share it with our support team.  

#### How to download application logs?

1. Open the `Tasks & Apps` section in the left sidebar.  
![Tasks & Apps]()

2. Check if the needed session is in the `Tasks` tab.  

![Tasks Tab]()

3. If not, open the `Apps` tab, find the needed application and click on the button under it.  

![Apps Tab]()

4. If on the `Tasks` tab, click on the three dots icon and select the `Logs` option. On the `Apps` tab simply click on the `Logs` button.  

![Logs Tab three dots]()

![Apps Tab Logs]()

5. Click on the `Download Logs` button.  

![Download Logs]()

6. Now, when you downloaded the logs, please share them with our support team for further assistance.

#### Changing the log level of application

In some cases, we'll need additional logs to diagnose the issue. You can change the log level of an application by following these steps:

1. When launching the application click on the `Advanced settings` option.  
2. Find the `Log Level` option and change it to `Debug` or `Trace` to capture more detailed logs.  

![Change Log Level]()

Now, you can use the application as usual, and it will generate more verbose logs. If you encounter any issues, please [download the logs](#how-to-download-application-logs) and share them with our support team.


### Issues with the platform

If you encounter an error in the graphical user interface while not using any specific application:

- **Community Edition**: Please contact our support team with a description of the issue.  
- **Enterprise Edition**: Before reaching out, if you're not using [Cloud-hosted Enterprise Instance](#cloud-hosted-enterprise-instances), and the [Remote Logs](#enabling-remote-logs) feature is not enabled, please [generate a troubleshoot archive](https://docs.supervisely.com/enterprise-edition/advanced-tuning/generating_ts_archive) and share it with our support team. This helps us resolve your issue faster.


#### Enabling Remote Logs

When something goes wrong, the fastest way for our team to help is by seeing what the system sees.  
Remote logs allow Enterprise customers to securely send system-level logs to the Supervisely team in real time—so we can diagnose and resolve issues without needing a manual troubleshooting archive.

To enable remote log forwarding, run:

```bash
sudo supervisely enable-remote-logs
```

To disable it at any time, use:

```bash
sudo supervisely disable-remote-logs
```

**What’s sent? Only system logs.**  

Remote logging transmits **only non-sensitive system-level diagnostics**—such as service status, error traces, and performance metrics.  
It does **not include any personal data, customer content, project files, credentials, or identifiable information**.  

We take customer privacy seriously. Remote logs are strictly limited to what’s necessary for technical troubleshooting and are handled securely by the Supervisely team.  
This ensures faster support without compromising your data integrity or confidentiality.