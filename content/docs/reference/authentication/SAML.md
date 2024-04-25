# SAML

SAML can be configured by setting up the `saml` section in the `authentication` section of the MKE4 config. This also has its own `enabled` field which is disabled by default and must be switched to 'true' to enable SAML.

The remaining fields are used to configure the SAML provider. Many of these fields can be found as part of the [Dex SAML documentation](https://dexidp.io/docs/connectors/saml/).

| Field                           | Description                                                                                                                                                 |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| enabled                         | Enable authentication through dex                                                                                                                           |
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
    ssoURL: https://dev-64105006.okta.com/app/dev-64105006_mke4saml_1/epkdtszgindywD6mF5s7/sso/saml
    redirectURI: http://dex:5556/callback
    localCa: /etc/ssl/okta.cert
    usernameAttr: name
    emailAttr: email
```

Use the next section to understand how to configure Okta. Once the configuration is set, run the standard `mkectl apply` command with your config file and wait for the cluster to be ready.

## Configuring Okta

Create a new application in Okta and use the following settings:

1. Sign-in method: SAML 2.0
2. App name: Any name you can remember
3. The host for your redirect URLs **need to be understood by your browser**. For this reason, we could use `localhost:5556` or `127.0.0.1:5556` if you are running the MKE4 cluster on your local system and doing the port forward (see flow setup). Since the cluster is not usually running locally, this will be an actual URL. `dex` can be added to the system's `/etc/hosts` file. This is used as the cluster host throughout the rest of this guide. If you are running in AWS or elsewhere, you will need to use the actual URL of the cluster and whatever port you setup to expose 5556 of the Dex service.
   Single sign-on URL: http://{host}/callback
   Audience URI (SP Entity ID): http://{host}/callback
   Attribute statements:
   - Name: email
     Value: user.email
   - Name: name
     Value: user.login
4. Save
5. Finish

Okta will generate the `ssoURL` and cert under the `Sign On` tab.
The `ssoURL` will be the MetadataURL with the final metadata removed from the path.
The cert can be downloaded from the SAML Signing Certificates section. Click Actions on the active cert and download the cert.
Use these in your MKE4 config.

## Authentication Flow

Do the following in the browser to test the authentication flow:

1. Navigate to `http://localhost:5555/login`
2. Enter "example-app" in the "Authenticate for:" field. Leave the others fields as they are
3. Click the `Login` button
4. On the login page, select "Log in with SAML"
5. You will be redirected to the IdP's login page. Enter your credentials and click `Sign In`
6. Successful authentication will redirect you back to the example-app with a plain white page with all of your authentication details
