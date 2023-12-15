In Supervisely multiple users can create accounts, login using passwords and collaborate together in teams.

Supervisely Enterprise Edition supports more advanced use cases, such as Single Sign-On (SSO) from one of many providers including OpenID or LDAP, or special authentication requirements.

{% hint style="note" %}
Superadmin user (the one with login "admin") always uses internal authorization scheme with password to allow platform configuration even with incorrect SSO settings.
{% endhint %}

## OpenID (OIDC, Azure, etc...)

The simplest way to configure Open ID authorization is to use the Instance Settings page.

Login as "admin" user and select "Instance Settings" under the user menu in the top right corner of your screen. Scroll down to the Authorization section and select Open ID authorization.

![Configure OpenID at the Instance Settings page](./openid.png)

Click the "Add" button and provide credentials to your Open ID authorization provider.

Do not forget to click the "Save" button at the bottom to apply your changes.

![Configure OpenID at the Instance Settings page](./openid-modal.png)

<details>

<summary>Manual configuration using docker-compose.override.yml</summary>

If you have troubles with using the Instance Settings page, you can configure Open ID authorization manually.

1\. Open terminal and go to the Supervisely configs folder

```sh
$ cd $(sudo supervisely where)
```

2\. Create `openid.yml` file with external service credentials

```yaml
<provider_name>:
  metadata_url: <metada_url>
  client_id: <client_id>
  client_secret: <client_secret>

  # optional
  http_proxy: <proxy url>
  https_proxy: <proxy url>
  icon: <url> / <base64> / <svg> (login button icon)
  login_label: <login_label> (login button label)
  extra_scope: <array> (list of additional scopes) # deprecated, use extra_settings.scope
  extra_settings: # <optional object if specific settings are required>
    scope: <array> (list of additional scopes)
    token_endpoint_auth_method: <string>
    acr_values: <string>
```

3\. Create `docker-compose.override.yml` file

```yaml
version: '2.4'

services:
  api:
    environment:
      DOMAIN: <https_instance_domain>
    volumes:
    - <path_to_folder>/openid.yml:/openid.yml:ro
```

>Notice: if you update the `openid.yml` file later then you need to execute `sudo supervisely restart api` instead of `up -d`

4\. Execute following command

```sh
$ sudo supervisely up -d
```

5\. Go to your authorization service and add new redirect (callback) URI `<https_instance_domain>/api/account/auth/<provider_name>/callback`
where:
  - https_instance_domain - domain, that you specified in `docker-compose.override.yml`
  - provider_name - name, that you specified in `openid.yml`

</details>
