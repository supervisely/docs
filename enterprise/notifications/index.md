# Notifications

## Notification via email

{% hint style="info" %}
Email notification available only for labeling jobs.
Notifications are available only if the "Send notifications" field is filled.
{% endhint %}

To activate email notifications add `SMTP_MAILING_CREDENTIALS` and `NOTIFICATIONS_EMAIL` variables to `.env` file. For example:

```
SMTP_MAILING_CREDENTIALS=smtps://username:password@smtp.example.com
NOTIFICATIONS_EMAIL=notification@company.com
```

## Notifications via endpoint

If you need to get notifications on your server you can specify `NOTIFICATIONS_URL`  variable in `.env` file. For example:

```
NOTIFICATIONS_URL=localhost/notifications
```

Notifications in the following format will be sent to specified url:
```
{
    "id": 301,
    "createdAt": "2020-04-27T11:32:28.003Z",
    "status": "unread",
    "userId": 1,
    "groupId": 1,
    "type": "job_assigned",
    "meta": {
        "id": 455,
        "teamTitle": "admin",
        "title": "Annotation Job (#1)"
    },
    "title": "New job assigned",
    "description": "\"Annotation Job (#1)\" was assigned to you"
}
```
