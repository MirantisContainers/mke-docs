---
title: Authentication
weight: 1
---

Mirantis Kubernetes Engine (MKE) supports OpenID Connect (OIDC),
Security Assertion Markup Language (SAML), and Lightweight Directory
Access Protocol (LDAP) authentication methods.

MKE uses Dex for authentication. If you want to use a different authentication
component, disable the authentication in the MKE configuration file and add
your preferred method.

{{< callout type="warning" >}}
  Be aware that if you opt to use an authentication method other than Dex,
   you will need to undertake all tasks and responsibilities associated with
   configuring and maintaining that method.
{{< /callout >}}

## Prerequisites

- **Identity Provider (IdP):** To set OIDC or SAML you need to configure an IdP
  with an application. Refer to [OIDC](../../operations/authentication/oidc-providers/oidc) or
  [SAML](../../operations/authentication/saml-providers/saml) for detailed procedures.

- **LDAP Server:** To set LDAP, configure the LDAP server with the users as described in
  [LDAP](../../operations/authentication/ldap).

## Configuration

You can configure authentication for MKE through the `authentication` section
of the MKE configuration file.

Authentication is enabled by default. However, the settings for each of the individual
authentication methods are disabled. To enable a service, set its `enabled` configuration
option to `true`. Doing so will install the authentication method of your choice
on your cluster.

```yaml
authentication:
  enabled: true
```
