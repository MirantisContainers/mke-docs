# SAML

SAML can be configured by setting up the `saml` section in the `authentication` section of the MKE4 config. This also has its own `enabled` field which is disabled by default and must be switched to 'true' to enable SAML.

The remaining fields are used to configure the SAML provider. Many of these fields can be found as part of the [Dex SAML documentation](https://dexidp.io/docs/connectors/saml/).

| Field                           | Description                                                                                                                                                 |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| enabled                         | Enable authentication through dex                                                                                                                           |
| ssoMetadataURL                  | The metadata url provided by some IdPs. MKE can use this to retrieve information for all other SAML configuration automatically                             |
| ca                              | Alternative to caData and localCa. CA to use when validating the signature of the SAML response. This must be manually mounted in a local accessible by dex |
| caData                          | Alternative to ca and localCa. Place the cert data directly in the config file                                                                              |
| localCa                         | Alternative to ca and caData. A path to a Ca file the local system. MKE will mount and create a secret for the cert                                         |
| ssoURL                          | The URL to send users to when signing in with SAML. Provided by the IdP                                                                                     |
| redirectURI                     | Dex's callback URL. Where users will be returned to after successful authentication with the IdP                                                            |
| insecureSkipSignatureValidation | Skip the signature validation. This should only be used for testing purposes (optional)                                                                     |
| usernameAttr                    | A username attribute in the returned assertions to map to ID token claims                                                                                   |
| emailAttr                       | An email attribute in the returned assertions to map to ID token claims                                                                                     |
| groupsAttr                      | A groups attribute in the returned assertions to map to ID token claims (optional)                                                                          |
| entityIssuer                    | Include this as the Issuer value during AuthnRequest (optional)                                                                                             |
| ssoIssuer                       | Issuer value expected in the SAML response (optional)                                                                                                       |
| groupsDelim                     | If groups are assumed to be represented as a single attribute, this delimiter is used to split the attribute's value into multiple groups (optional)        |
| nameIDPolicyFormat              | Requested format of the NameID                                                                                                                              |

An example configuration for SAML is shown below:

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

Use the next section to understand how to configure Okta and find the values for the example config above. Once the configuration is set, run the standard `mkectl apply` command with your config file and wait for the cluster to be ready.

## Configuring Okta

Create a new application in Okta and use the following settings:

1. Sign-in method: SAML 2.0
2. App name: Any name you can remember
3. The host for your redirect URLs
   - Single sign-on URL: `http://{MKE hostname}/callback`
   - Audience URI (SP Entity ID): `http://{MKE hostname}/callback`
   - Attribute statements:
     - Name: email
       <br>Value: user.email
     - Name: name
       <br>Value: user.login
4. Save
5. Finish
6. Navigate to the `Assignments` tab
   <br>a. Click on `Assign` -> `Assign to people`
   <br>b. Find the account you would like to use for authentication and click the blue `Assign` button on the right

Okta will generate the `ssoURL` and cert under the `Sign On` tab.
The `ssoURL` will be the MetadataURL with the final metadata removed from the path.
The cert can be downloaded from the SAML Signing Certificates section. Click Actions on the active cert and download the cert.
Configure the `localCa` to point to this file on your system that you will run `mkectl` from. The cert in the example above is stored in `/etc/ssl/okta.cert`.

## Authentication Flow

> Ports `5556` (dex) and `5555` (example-app) will need to be available externally to test the authentication flow.

Do the following in the browser to test the authentication flow:

1. Navigate to `http://{MKE hostname}:5555/login`
2. Click the `Login` button
3. On the login page, select "Log in with SAML"
4. You will be redirected to the IdP's login page. Enter your credentials and click `Sign In`
5. Successful authentication will redirect you back to the client applications home page
