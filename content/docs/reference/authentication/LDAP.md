# LDAP

LDAP can be configured by setting up the `ldap` section in the `authentication` section of the MKE4 config. This also has its own `enabled` field which is disabled by default and much be switched to 'true' to enable LDAP.

The remaining fields are used to configure the interactions with your LDAP server. Full details of these fields can be found in the (https://dexidp.io/docs/connectors/ldap/#configuration)[dex documentation] .

| Field                            | Description                                                               |
| -------------------------------- | ------------------------------------------------------------------------- |
| host                             | Host and optional port of the LDAP server in the form "host:port"         |
| rootCA                           | Path to a trusted root certificate file                                   |
| bindDN                           | The DN for an application service account                                 |
| bindPW                           | The password for an application service account                           |
| usernamePrompt                   | The attribute to display in the provided password prompt                  |
| userSearch                       | Settings to map a username and password entered by a user to a LDAP entry |
| userSearch.baseDN                | BaseDN to start the search from                                           |
| userSearch.filter                | Optional filter to apply when searching the directory                     |
| userSearch.username              | username attribute used for comparing user entries                        |
| userSearch.idAttr                | String representation of the user                                         |
| userSearch.emailAttr             | Attribute to map to Email.                                                |
| userSearch.nameAttr              | Maps to display name of user                                              |
| userSearch.preferredUsernameAttr | Maps to preferred username of users                                       |
| groupSearch                      | Group search queries for groups given a user entry                        |
| groupSearch.baseDN               | BaseDN to start the search from                                           |
| groupSearch.filter               | Optional filter to apply when searching the directory                     |
| groupSearch.userMatchers         | A list of field pairs that are used to match a user to a group            |
| groupSearch.nameAttr             | Represents group name                                                     |

An example configuration for LDAP is shown below.

```yaml
authentication:
  enabled: true
  ldap:
    enabled: true
    host: <your LDAP server and port>
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

## Authentication Flow

Do the following in the browser to test the authentication flow:

1. Navigate to `http://<MKE4 cluster external hostname>:5555/login`
2. Click the `Login` button
3. On the login page, select "Log in with LDAP"
4. Enter the username and password for the LDAP server
5. Click the `Login` button
6. You should now be logged in and see application's home page
