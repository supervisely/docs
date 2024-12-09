# Server stats and errors

The **Server Stats and Errors** section provides administrators with valuable insights into server performance, user activity, and error monitoring. By offering real-time data and logs, it helps in diagnosing issues, optimizing server usage, and improving overall operational.

## Server Stats

The Server Stats module is designed to:

1. **Monitor user activity**: Track signups, active users, and retention metrics over specific time periods.
2. **Analyze team and workspace growth**: View trends in team creation and workspace usage.
3. **Optimize resource usage**: Gain insights into server usage to plan resource allocation.

<figure><img src="../../.gitbook/assets/Screenshot 2024-12-09 at 13.45.27.png" alt=""><figcaption></figcaption></figure>

***

### **Categories**

**Users**:

* **Total Count**: Displays the total number of registered users on the server. Useful for understanding the overall user base size.
* **Signups**: Indicates the number of new accounts created within the selected time period. Helps track user growth.
* **Signups (Confirmed)**: Tracks confirmed user registrations. Useful for analyzing verified user onboarding.
* **Signups (Social)**: Reflects new signups via social platforms. Shows adoption from integrated social channels.
* **Fresh Domains**: Represents signups from unique email domains. Useful for monitoring diversity in user registrations.
* **Active**: Counts users who performed at least one action (e.g., labeling, running tasks) during the selected period. Key metric for user engagement.
* **Retained**: Represents users who registered earlier and performed actions during the selected period. Measures long-term engagement.

**Teams & Workspaces**:

* **Created Teams**: Displays the total number of new teams created on the server. Useful for tracking team activity and collaboration growth.
* **Created Workspaces**: Shows the number of new workspaces created. Indicates organizational growth.
* **Avg Users Count**: Reflects the average number of users in teams with two or more members. Helps analyze collaboration levels.
* **Users Count (Created Teams)**: Number of users who created at least one team. Tracks active team creators.
* **Users Count (Created Workspaces)**: Number of users who created at least one workspace. Highlights workspace contributors.

**Projects**:

* **Total Count**: Displays the total number of projects on the server. Useful for understanding the overall scope of work.
* **Count in Period**: Number of projects created during the selected time period. Tracks project activity.
* **Local Count**: Shows the number of locally created projects. Indicates server-based project creation.
* **Imported Count**: Reflects the number of projects imported from external sources. Useful for identifying data integrations.

**Tasks**:

* **By Type (Successful)**: Breaks down successfully completed tasks by type (e.g., clone, app). Helps monitor task outcomes.
* **By Type (Failed)**: Displays the count of failed tasks by type. Useful for identifying problem areas.
* **By Status**: Shows tasks grouped by their current status (e.g., queued, started, error). Key for task monitoring and issue resolution.

**Shares**:

* **Links Created**: Number of links generated for sharing data or projects. Useful for tracking resource distribution.
* **Users with Links**: Reflects the number of users who created at least one link. Shows adoption of sharing functionality.

**Agents**:

* **Total Agents**: Total number of agents registered on the server. Useful for understanding infrastructure size.
* **Created Agents**: Number of new agents added during the selected period. Tracks growth in agent resources.
* **Active Agents**: Number of agents that sent hardware info during the selected period. Indicates active resources.

**Jobs**:

* **Total Jobs**: Total number of jobs created on the server. Reflects server usage for task processing.
* **Created Jobs**: Number of jobs created during the selected period. Tracks job creation trends.
* **Users with Jobs**: Number of users who created at least one job. Highlights task contributors.

**Models**:

* **Total Models**: Displays the total number of models on the server. Useful for understanding modeling activity.
* **Created Models**: Number of new models created during the selected period. Tracks development of new models.
* **Trained Models**: Reflects models that have completed training. Key metric for model development progress.
* **Users with Models**: Number of users who created at least one model. Highlights active contributors to model development.

**Python Notebooks**:

* **Total Containers Created**: Number of containers created for Python notebooks. Indicates server activity related to scripting.
* **Notebooks Added**: Reflects new notebooks added during the selected period. Tracks growth in notebook resources.
* **Containers Created**: Shows notebooks that have been run at least once. Highlights active scripting tasks.
* **Containers Running Now**: Indicates the number of currently active notebook containers. Useful for real-time monitoring.
* **Containers Lifetime**: Displays the average lifetime of notebook containers. Useful for understanding resource consumption patterns.
* **Created Teams**: Total number of teams created.

***

## Server Errors

The Server Errors module helps diagnose and resolve application or system-level issues. By providing detailed logs, it allows admins to:

1. **Identify errors**: Quickly locate application errors or failures.
2. **Monitor frequency**: Track the number of error events over time.
3. **Resolve issues**: Use logs and configuration data to fix problems efficiently.

<figure><img src="../../.gitbook/assets/Screenshot 2024-12-09 at 14.04.49.png" alt=""><figcaption></figcaption></figure>

**Error Logs**

Error logs provide detailed information about system and application errors, enabling efficient identification and resolution of issues. Key components include:

* **Error Type**: Categorizes the source of the error (e.g., App, System). This helps determine if the issue originates from user actions, applications, or server infrastructure.
* **User**: Identifies the user associated with the error event, useful for tracking user-specific issues and providing targeted support.
* **Agent**: Shows the hardware or environment (e.g., Kubernetes, specific agents) where the error occurred. This aids in diagnosing infrastructure-related issues.
* **Date**: Displays when the error happened. Useful for correlating errors with recent changes or activities.
* **Duration**: Indicates how long the error lasted, helping prioritize issues that have a greater impact on system performance.
* **Events**: Tracks the frequency of the specific error type, helping to identify recurring or widespread issues.
* **Actions**:
  * **Show Log**: Access detailed error logs for in-depth debugging and root cause analysis.
  * **Show Config**: View configuration settings associated with the error to verify or adjust settings to resolve the issue.
