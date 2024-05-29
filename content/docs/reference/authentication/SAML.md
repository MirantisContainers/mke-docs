# SAML

Security Assertion Markup Language (SAML) can be configured in
the `authentication` section of the Mirantis Kubernetes Engine (MKE) 4 config. 
SAML is disabled by default, to enable it set `enabled` to `true`.

The remaining fields in the `authentication.saml` section are used to configure
the SAML provider. Refer to [Configure Okta](#configure-okta) for
instructions on how to obtain the field values. For more details, see
[Authentication through SAML 2.0](https://dexidp.io/docs/connectors/saml/)
in the official Dex documentation.

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

The following table details the fields that you can configure in the
`authentication.saml` section of the MKE 4 config:

| Field                             | Description                                                                                                                                                      |
|-----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `enabled`                         | Enable authentication through dex.                                                                                                                               |
| `ssoMetadataURL`                  | The metadata URL provided by some IdPs. MKE can use this to retrieve information for all other SAML configuration automatically.                                 |
| `ca`                              | Alternative to `caData` and `localCa`. CA to use when validating the signature of the SAML response. This must be manually mounted in a local accessible by dex. |
| `caData`                          | Alternative to `ca` and `localCa`. Place the cert data directly in the config file.                                                                              |
| `localCa`                         | Alternative to `ca` and `caData`. A path to a CA file in the local system. MKE will mount and create a secret for the cert.                                      |
| `ssoURL`                          | The URL to send users to when signing in with SAML. Provided by the IdP.                                                                                         |
| `redirectURI`                     | Dex callback URL. Where users will be returned to after successful authentication with the IdP.                                                                  |
| `insecureSkipSignatureValidation` | Optional. Skip the signature validation. To be used for testing purposes only.                                                                                   |
| `usernameAttr`                    | A username attribute in the returned assertions to map to ID token claims.                                                                                       |
| `emailAttr`                       | An email attribute in the returned assertions to map to ID token claims.                                                                                         |
| `groupsAttr`                      | Optional. A groups attribute in the returned assertions to map to ID token claims.                                                                               |
| `entityIssuer`                    | Optional. Include this as the Issuer value during authentication request.                                                                                        |
| `ssoIssuer`                       | Optional. Issuer value expected in the SAML response.                                                                                                            |
| `groupsDelim`                     | Optional. If groups are assumed to be represented as a single attribute, this delimiter is used to split the attribute's value into multiple groups.             |
| `nameIDPolicyFormat`              | Requested format of the name ID.                                                                                                                                 |

## Configure Okta

Create a new application in Okta and use the following settings:

1. Select **SAML 2.0** as the **Sign-in method**.
2. Choose an app integration name that you can easily remember.
3. The host for your redirect URLs:
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

   b. Find the account you would like to use for authentication and click the blue **Assign** button on the right.

Okta will generate the `ssoURL` and cert under the `Sign On` tab.
The `ssoURL` will be the MetadataURL with the final metadata removed from the path.
The cert can be downloaded from the SAML **Signing Certificates** section.
Click **Actions** on the active cert and download the cert.
Configure the `localCa` to point to this file on your system that you will run `mkectl` from.
The cert in the example above is stored in `/etc/ssl/okta.cert`.

Once the configuration is set, run the `mkectl apply` command with your
configuration file and wait for the cluster to be ready.

## Authentication flow

!!! tip "Testing"

    Ports `5556` (dex) and `5555` (example-app) need to be available externally
    to test the authentication flow.

In the browser, perform the following steps to test the authentication flow:

1. Navigate to `http://{MKE hostname}:5555/login`.
2. Click **Login**.
3. On the login page, select **Log in with SAML**.
4. You will be redirected to the IdP's login page. Enter your credentials and click **Sign In**.
5. Successful authentication will redirect you back to the client applications home page.
