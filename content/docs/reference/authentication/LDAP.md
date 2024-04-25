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

An example configuration for OIDC is shown below. This configuration is for a development LDAP server running on the same machine as the cluster. See the instructions below for running the development LDAP server.

```yaml
authentication:
  enabled: true
  ldap:
    enabled: true
    host: localhost:389
    insecureNoSSL: true
    bindDN: cn=admin,dc=mirantis,dc=org
    bindPW: admin
    usernamePrompt: Email Address
    userSearch:
      baseDN: ou=People,dc=mirantis,dc=org
      filter: "(objectClass=person)"
      username: mail
      idAttr: DN
      emailAttr: mail
      nameAttr: cn
```

> **Note** I had to point the host to my dev machines local IP rather then localhost for this to work with the development LDAP server. This is because the cluster is running in a VM and the LDAP server is running on the host machine.

Use the next section to setup a development LDAP server. Once server is running, run the standard MKE4 apply command with your config file and wait for the cluster to be ready.

## Running a Development LDAP Server

> **Note** Running the development server requires (Docker and docker compose)[https://docs.docker.com/engine/install/] to be installed on your machine. Docker compose is now part of docker

An LDAP for development purposes is already available in the `deployments/ldap/` directory. This is a simple LDAP server that can be used to test the LDAP authentication flow.

To run the LDAP server, change to the `deployments/ldap/` directory and run the compose file.

```bash
cd deployments/ldap
docker compose up
```

This docker compose file will copy in the `config-ldap.ldif` configuration file and use it when setting up the LDAP server. The server will expose the LDAP service on port 389 for non-tls and 636 for tls.

## Authentication Flow

Do the following in the browser to test the authentication flow:

1. Navigate to `http://localhost:5555/login`
2. Enter "example-app" in the "Authenticate for:" field. Leave the others fields as they are
3. Click the `Login` button
4. On the login page, select "Log in with LDAP"
5. Enter one of the user's emails from the `config-ldap.ldif` file. ex: janedoe@example.com
6. Enter one of the user's passwords. ex: `foo`
7. Click the `Login` button
8. You should now be logged in and see the user's token information displayed on an otherwise blank page
