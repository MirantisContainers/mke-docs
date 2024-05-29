# LDAP

LDAP (Lightweight Directory Access Protocol) can be configured in
the `authentication` section of the Mirantis Kubernetes Engine (MKE) 4 config.
LDAP is disabled by default, to enable it set `enabled` to `true`.

The remaining fields in the `authentication.ldap` section are used to configure
the interactions with your LDAP server. For more details, refer to
[LDAP configuration](https://dexidp.io/docs/connectors/ldap/#configuration)
in the official Dex documentation.

An example configuration for LDAP:

```yaml
authentication:
  enabled: true
  ldap:
    enabled: true
    host: ldap.example.org:389
    insecureNoSSL: true
    bindDN: cn=admin,dc=example,dc=org
    bindPW: admin
    usernamePrompt: Email Address
    userSearch:
      baseDN: ou=People,dc=example,dc=org
      filter: "(objectClass=person)"
      username: mail
      idAttr: DN
      emailAttr: mail
      nameAttr: cn
```

The following table details the fields that you can configure in the
`authentication.ldap` section of the MKE 4 config:

| Field                              | Description                                                                |
|------------------------------------|----------------------------------------------------------------------------|
| `host`                             | Host and optional port of the LDAP server in the `host:port` format.       |
| `rootCA`                           | Path to a trusted root certificate file.                                   |
| `bindDN`                           | The DN for an application service account.                                 |
| `bindPW`                           | The password for an application service account.                           |
| `usernamePrompt`                   | The attribute to display in the provided password prompt.                  |
| `userSearch`                       | Settings to map a username and password entered by a user to a LDAP entry. |
| `userSearch.baseDN`                | BaseDN to start the search from.                                           |
| `userSearch.filter`                | Optional filter to apply when searching the directory.                     |
| `userSearch.username`              | Username attribute used for comparing user entries.                        |
| `userSearch.idAttr`                | String representation of the user.                                         |
| `userSearch.emailAttr`             | Attribute to map to email.                                                 |
| `userSearch.nameAttr`              | Maps to display name of a user.                                            |
| `userSearch.preferredUsernameAttr` | Maps to preferred usernames of users.                                      |
| `groupSearch`                      | Group search queries for groups given a user entry.                        |
| `groupSearch.baseDN`               | BaseDN to start the search from.                                           |
| `groupSearch.filter`               | Optional filter to apply when searching the directory.                     |
| `groupSearch.userMatchers`         | A list of field pairs that are used to match a user to a group.            |
| `groupSearch.nameAttr`             | A group name.                                                              |

## Authentication flow

!!! tip "Testing"

    Ports `5556` (dex) and `5555` (example-app) need to be available externally
    to test the authentication flow.

In the browser, perform the following steps to test the authentication flow:

1. Navigate to `http://{MKE hostname}:5555/login`.
2. Click **Login**.
3. On the login page, select **Log in with LDAP**.
4. Enter the username and password for the LDAP server.
5. Click **Login**.
6. Successful authentication will redirect you back to the client applications home page.
