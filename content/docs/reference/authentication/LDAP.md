# LDAP

LDAP (Lightweight Directory Access Protocol) can be configured in
the `authentication` section of the Mirantis Kubernetes Engine (MKE) 4 config.
LDAP is disabled by default, to enable it set `enabled` to `true`.

The remaining fields in the `authentication.ldap` section are used to configure
the interactions with your LDAP server. For more details, refer to
[LDAP configuration](https://dexidp.io/docs/connectors/ldap/#configuration)
in the official Dex documentation.

The following table details the fields that you can configure in the
`authentication.ldap` section of the MKE 4 config:

| Field                              | Description                                                                |
|------------------------------------|----------------------------------------------------------------------------|
| `host`                             | Host and optional port of the LDAP server, in the `host:port` format.      |
| `rootCA`                           | Path to a trusted root certificate file.                                   |
| `bindDN`                           | Distinguished Name (DN) for an application service account.                                |
| `bindPW`                           | Password for an application service account.                           |
| `usernamePrompt`                   | Attribute to display in the password prompt.                  |
| `userSearch`                       | Settings to map user-entered username and password to an LDAP entry. |
| `userSearch.baseDN`                | BaseDN from which to start the search.                                           |
| `userSearch.filter`                | Optional filter to apply for a user search of the directory.                     |
| `userSearch.username`              | Username attribute to use for user entry comparison.                        |
| `userSearch.idAttr`                | String representation of the user.                                         |
| `userSearch.emailAttr`             | Attribute to map to email.                                                 |
| `userSearch.nameAttr`              | Attribute to map to display name of a user.                                            |
| `userSearch.preferredUsernameAttr` | Attribute to map to preferred usernames.                                      |
| `groupSearch`                      | Group search queries for groups given a user entry.                        |
| `groupSearch.baseDN`               | BaseDN from which to start the search.                                           |
| `groupSearch.filter`               | Optional filter to apply for a group search of the directory.                               |
| `groupSearch.userMatchers`         | Field pairs list to use to match a user to a group.            |
| `groupSearch.nameAttr`             | Group name.                                                              |

LDAP example configuration:

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

**To test the Authentication flow:**

---
***Note***

Ports `5556` (dex) and `5555` (example-app) need to be available externally
to test the authentication flow.

---

In the browser, perform the following steps to test the authentication flow:

1. Navigate to `http://{MKE hostname}:5555/login`.
2. Click **Login** to display the login page.
3. Select **Log in with LDAP**.
4. Enter the username and password for the LDAP server.
5. Click **Login**. If authentication is successful, you will be redirected to the client applications home page.
6. Successful authentication will redirect you back to the client applications home page.
