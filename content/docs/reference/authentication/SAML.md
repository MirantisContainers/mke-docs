# SAML

Security Assertion Markup Language (SAML) can be configured in
the `authentication` section of the Mirantis Kubernetes Engine (MKE) 4 config. 
SAML is disabled by default, to enable it set `enabled` to `true`.

The remaining fields in the `authentication.saml` section are used to configure
the SAML provider. Refer to [Configure Okta](#configure-okta) for
instructions on how to obtain the field values. For more details, see
[Authentication through SAML 2.0](https://dexidp.io/docs/connectors/saml/)
in the official Dex documentation.

The following table details the fields that you can configure in the
`authentication.saml` section of the MKE 4 config:

| Field                             | Description                                                                                                                                                      |
|-----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `enabled`                         | Enable authentication through dex.                                                                                                                               |
| `ssoMetadataURL`                  | Metadata URL provided by some IdPs, with which MKE can retrieve information for all other SAML configurations.                                 |
| `ca`                              | Certificate Authority (CA) alternative to `caData` and `localCa`, to use when validating the signature of the SAML response. Must be manually mounted in a local accessible by dex. |
| `caData`                          | CA alternative to `ca` and `localCa`, which you can use to place the certificate data directly into the config file.                                                                              |
| `localCa`                         | Alternative to `ca` and `caData`. A path to a CA file in the local system, with which MKE mounts and creates a secret for the certificate.                                      |
| `ssoURL`                          | URL to provide to users to sign into MKE 4 with SAML. Provided by the IdP.                                                                                         |
| `redirectURI`                     | Callback URL for dex to which users are returned to following successful IdP authentication.                                                                  |
| `insecureSkipSignatureValidation` | Optional. Use to skip the signature validation. For testing purposes only.                                                                                   |
| `usernameAttr`                    | Username attribute in the returned assertions, to map to ID token claims.                                                                                       |
| `emailAttr`                       | Email attribute in the returned assertions, to map to ID token claims.                                                                                         |
| `groupsAttr`                      | Optional. Groups attribute in the returned assertions, to map to ID token claims.                                                                               |
| `entityIssuer`                    | Optional. Include as the Issuer value during authentication requests.                                                                                        |
| `ssoIssuer`                       | Optional. Issuer value that is expected in the SAML response.                                                                                                            |
| `groupsDelim`                     | Optional. If groups are assumed to be represented as a single attribute, this delimiter splits the attribute value into multiple groups.             |
| `nameIDPolicyFormat`              | Requested name ID format.                                                                                                                                 |

An example configuration for SAML:

```yaml
authentication:
  enabled: true
  saml:
    enabled: true
    ssoURL: https://dev64105006.okta.com/app/dev64105006_mke4saml_1/epkdtszgindywD6mF5s7/sso/saml
    redirectURI: http://{MKE host}:5556/callback
    localCa: /etc/ssl/okta.cert
    usernameAttr: name
    emailAttr: email
```

**To configure and create a new application in Okta:

Create a new application in Okta and use the following settings:

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

Okta will generate the `ssoURL` and cert under the `Sign On` tab.
The `ssoURL` will be the MetadataURL with the final metadata removed from the path.
The cert can be downloaded from the SAML **Signing Certificates** section.
Click **Actions** on the active cert and download the cert.
8. Configure the `localCa` to point to the downloaded certificate file.
The cert in the example above is stored in `/etc/ssl/okta.cert`.

Once the configuration is set, run the `mkectl apply` command with your
configuration file and wait for the cluster to be ready.

**To test the Authentication flow:**

---
***Note***

Ports `5556` (dex) and `5555` (example-app) need to be available externally
to test the authentication flow.

---

In the browser, perform the following steps to test the authentication flow:

1. Navigate to `http://{MKE hostname}:5555/login`.
2. Click **Login** to display the login page.
3. Select **Log in with SAML**.
4. Enter your credentials and click **Sign In**. If authentication is successful, you will be redirected to the client applications home page.
5. Successful authentication will redirect you back to the client applications home page.
