# Members

A user in a particular team is called "member". Every user can be a member of one, many or even zero teams, but a team cannot exist without at least one member. Members can leave the team at any moment, but only team's `admin` can remove other members from the team. 

## Roles

Each team member has a role in the team that specifies what kind of actions they can do. For example, `admin` can invite new members, while `developer` cannot. The same user can have different roles in different teams.

At the moment the following roles are available:

- **Admin**: Has full access in the team. Admin can invite new team members and remove entities created by the other team members.
- **Developer**: Similar to the admin, but can only remove entities created by themself and cannot invite new members to the team.
- **Manager**: Has no access to things like Python Notebooks or Neural Networks, but can view and modify Projects & Labeling Jobs
- **Annotator**: Has access only to a single page, Labeling Jobs.
- **Viewer**: can only view items in team

Every team must have at least one `admin`, but can have two or more.

Here is the full list of roles permissions:

| Actions                   | Admin         | Developer     | Manager       | Viewer        | Annotator     |
| :------------------------ | :-----------: | :-----------: | :-----------: | :-----------: | :-----------: |
| **DTL**                   | ✅             | ✅             |               |               |               |
| **Import**                | ✅             | ✅             |               |               |               |
| **Neural Networks**       | ✅             | ✅             |               |               |               |
| **Python Notebooks**      | ✅             | ✅             |               |               |               |
| **Tasks**                 | ✅             | ✅             |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Teams**                 |               |               |               |               |               |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               |               |
| &#8192;&#8192; Remove own | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Remove all | ✅             |               |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Members**               |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             |               |               |               |
| &#8192;&#8192; View       | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Create     | ✅             |               |               |               |               |
| &#8192;&#8192; Edit       | ✅             |               |               |               |               |
| &#8192;&#8192; Leave Team | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Remove all | ✅             |               |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Workspaces**            |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             | ✅             | ✅             |               |
| &#8192;&#8192; View       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit       | ✅             |               |               |               |               |
| &#8192;&#8192; Remove own | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Remove all | ✅             |               |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Plugins**               |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             |               |               |               |
| &#8192;&#8192; View       | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Remove own | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Remove all | ✅             |               |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Nodes**                 |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             |               |               | ✅             |
| &#8192;&#8192; View       | ✅             | ✅             |               |               | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit own   | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Remove own | ✅             | ✅             |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Labeling Jobs**         |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             |               |               | ✅             |
| &#8192;&#8192; View       | ✅             | ✅             |               |               | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             | ✅             |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               | ✅             |
| &#8192;&#8192; Remove     | ✅             | ✅             |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Projects**              |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             | ✅             | ✅             |               |
| &#8192;&#8192; View       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               |               |
| &#8192;&#8192; Remove own | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Remove all | ✅             |               |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Datasets**              |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; View       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               |               |
| &#8192;&#8192; Remove     | ✅             | ✅             |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Classes**               |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; View       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               |               |
| &#8192;&#8192; Remove     | ✅             | ✅             |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Tags**                  |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; View       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             | ✅             |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               |               |
| &#8192;&#8192; Remove     | ✅             | ✅             |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Images**                |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; View       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               |               |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               | ✅             |
| &#8192;&#8192; Remove     | ✅             | ✅             |               |               |               |
| &#8192;                   |               |               |               |               |               |
| **Figures**               |               |               |               |               |               |
| &#8192;&#8192; List       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; View       | ✅             | ✅             | ✅             | ✅             | ✅             |
| &#8192;&#8192; Create     | ✅             | ✅             |               |               | ✅             |
| &#8192;&#8192; Edit       | ✅             | ✅             | ✅             |               | ✅             |
| &#8192;&#8192; Remove own | ✅             | ✅             |               |               | ✅             |
| &#8192;&#8192; Remove all | ✅             | ✅             |               |               |               |
