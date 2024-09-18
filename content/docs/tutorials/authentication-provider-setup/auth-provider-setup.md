---
title: Authentication provider setup
weight: 1
---

Mirantis Kubernetes Engine (MKE) supports the following authentication
protocols:

- OpenID Connect (OIDC)
- Security Assertion Markup Language (SAML)
- Lightweight Directory Access Protocol (LDAP)

Identity providers, or IdPs, provide service in line with these authentication
protocols, the setup for which can differ significantly.

## OIDC setup<a name="oidc-provider-setup"></a>

Setup instruction is available below for the OIDC authentication providers that
are supported by MKE 4:

<details>
<summary>Okta</summary>

1. Select **OIDC - OpenID Connect** for **Sign-in method**.
2. Select **Web Application** for **Application Type**.
3. For **App integration name**, choose a name that you can easily remember.
4. Configure the host for your redirect URLs:
   - Sign-in redirect URIs: `http://{MKE hostname}/login`
   - Sign-out redirect URIs: `http://{MKE hostname}`
5. Click **Save** to generate the `clientSecret` and `clientID` in the `General` table of
the application.
6. Add the generated `clientSecret` and `clientID` values to your MKE configuration file.
7. Run the `mkectl apply` command with your MKE configuration file.

</details>


## SAML setup<a name="saml-provider-setup"></a>

Setup instruction is available below for the SAML authentication providers that
are supported by MKE 4:

<details>
<summary>Okta</summary>

1. Select **SAML 2.0** for **Sign-in method**.
2. For **App name**, choose a name that you can easily remember.
3. Configure the host for your redirect URLs:
   - Single sign-on URL: `http://{MKE hostname}/callback`
   - Audience URI (SP Entity ID): `http://{MKE hostname}/callback`
   - Attribute statements:
     - Name: email
       <br>Value: user.email
     - Name: name
       <br>Value: user.login
4. Click **Save**.
5. Click **Finish**.
6. Navigate to the **Assignments** tab:

   a. Click **Assign** -> **Assign to people**.

   b. Click the blue **Assign** button that corresponds to the account you want to use for authentication.

    Okta generates the `ssoURL` and certificate under the `Sign On` tab.
    The `ssoURL` is the MetadataURL with the final metadata removed from the path.

7. Download the certificate to the system from which you will run mkectl:

    a. Navigate to the SAML **Signing Certificates** section.

    b. Click **Actions** for the active certificate and initiate the download.

9. Run the `mkectl apply` command with your MKE configuration file.

</details>

For more information, refer to the official DEX documentation
[Authentication through SAML 2.0](https://dexidp.io/docs/connectors/saml/).
