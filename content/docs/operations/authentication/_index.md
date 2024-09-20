---
title: Authentication
weight: 1
---

By default, MKE is configured to use [Dex](https://dexidp.io/) for
authentication. To configure a different authentication component, edit the
`authentication` setting in the MKE configuration file to indicate your
preferred method.

<!-- [Flesh out specific MKE configuration file details] -->
<!-- [Text originally said to disable authentication in MKE config file and add your own. Too vague.] -->

{{< callout type="warning" >}}
  Be aware that if you opt to use an authentication component other than Dex,
   you will need to undertake all tasks and responsibilities associated with
   configuring and maintaining that method.
{{< /callout >}}

Mirantis Kubernetes Engine (MKE) supports the following authentication
protocols:

- OpenID Connect (OIDC)
- Security Assertion Markup Language (SAML)
- Lightweight Directory Access Protocol (LDAP)

## Prerequisites

You must have certain dependencies in place before you can configure
authentication. These dependencies differ, depending on which authentication
protocol you choose to deploy.

- **Identity Provider (IdP):** To set OIDC or SAML, you must configure an IdP
  with an application. Refer to [OIDC](../../operations/authentication/oidc-providers/oidc) or
  [SAML](../../operations/authentication/saml-providers/saml) for detailed information.

- **LDAP Server:** To set LDAP, configure the LDAP server with the users, as
  described in [LDAP](../../operations/authentication/ldap).

## Configuration

You configure authentication for MKE through the `authentication` section
of the MKE configuration file.

Authentication is enabled by default, however, the settings for each of the
individual authentication protocols are disabled. To enable and install an authentication protocol, set its `enabled` configuration option to `true`.

```yaml
authentication:
  enabled: true
```
