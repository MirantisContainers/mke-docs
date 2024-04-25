# Authentication

## Pre-requisites

- IdP - If you are setting up OIDC or SAML then you will need an IdP with an application configured. This example setup uses [okta](https://www.okta.com/)
- LDAP Server - If you are setting up LDAP then you will need an LDAP server with a user configured.

## Configuration

Authentication can be configured in the `authentication` section of the MKE4 config. By default, authentication is enabled but each of the individual authentication methods are disabled. It can be disabled by setting the root `enabled`to `false`. This will completely remove any authentication related components from being installed on the cluster.

```yaml
authentication:
  enabled: true
```

## Authentication Methods

From here, check out the individual files for the different authentication methods:

- [OIDC](./OIDC.md)
- [SAML](./SAML.md)
- [LDAP](./LDAP.md)
