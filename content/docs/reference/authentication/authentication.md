# Authentication

Mirantis Kubernetes Engine (MKE) 4 uses Dex for authentication.
If you want to use a different authentication method, disable
the authentication in the MKE configuration file and add your preferred method.

---
***CAUTION***

Changing the authentication method will require you to configure
authentication completely by yourself.

---

For more information on authentication feature status per release, go to
[MKE 4 releases](https://github.com/Mirantis/mke-docs/blob/main/content/releases/README.md).

## Prerequisites

- Identity Provider (IdP) - To set OIDC or SAML you need to configure an IdP with an application.
Refer to the official Okta documentation tutorial [Add a SAML Identity Provider](https://help.okta.com/en-us/content/topics/security/idp-add-saml.htm).
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

Documentation for specific authentication methods as they apply to MKE 4 is available:

- [OIDC (OpenID Connect)](OIDC.md)
- [SAML (Security Assertion Markup Language)](SAML.md)
- [LDAP (Lightweight Directory Access Protocol)](LDAP.md)
