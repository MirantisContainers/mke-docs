# Authentication

Mirantis Kubernetes Engine (MKE) 4 uses Dex for authentication.
If you choose to use a different authentication method, you can disable
the authentication in the MKE 4 configuration file and add your own method.

!!! caution "Changing authentication method"

    Changing the authentication method will require you to configure
    authentication completely by yourself.

For more information on authentication feature status in the release, go to
[MKE 4 releases](https://github.com/Mirantis/mke-docs/blob/main/content/releases/README.md).

## Prerequisites

- Identity Provider (IdP) - To set OIDC or SAML you need to configure an IdP with an application.
Refer to [Add a SAML Identity Provider](https://help.okta.com/en-us/content/topics/security/idp-add-saml.htm)
tutorial from the official Okta documentation.
- LDAP Server - To set LDAP you need to configure an LDAP server with a user.

## Configuration

Authentication can be configured in the `authentication` section of the MKE 4 config.
By default, authentication is enabled, but each of the individual authentication 
methods is disabled. It can be disabled by setting the root `enabled` to `false`. 
This will completely remove any authentication-related components from being
installed on the cluster.

```yaml
authentication:
  enabled: true
```

## Authentication methods

To learn more, refer to the documentation on specific authentication methods:

- [OpenID Connect (OIDC)](OIDC.md)
- [Security Assertion Markup Language (SAML)](SAML.md)
- [Lightweight Directory Access Protocol (LDAP)](LDAP.md)
