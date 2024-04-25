# OIDC

OIDC can be configured by setting up the `oidc` section in the `authentication` section of the MKE4 config. This also has its own `enabled` field which is disabled by default and must be switched to 'true' to enable OIDC.

The remaining fields are used to configure the OIDC provider.

| Field        | Description                                                               |
| ------------ | ------------------------------------------------------------------------- |
| issuer       | The root URL of the OIDC provider                                         |
| clientID     | The id from the IdP's application configuration                           |
| clientID     | The secret from the IdP's application configuration                       |
| redirect URI | The URI that the provider will be returning successful authentications to |

An example configuration for OIDC is shown below:

```yaml
authentication:
  enabled: true
  oidc:
    enabled: true
    issuer: https://dev-94406016.okta.com
    clientID: 0oedtjcjrjWab3zlD5d4
    clientSecret: DFA9NYLfE1QxwCSFkZunssh2HCx16kDl41k9tIBtFZaNcqyEGle8yZPtMBesyomD
    redirectURI: http://dex.example.com:32000/callback
```

Use the next section to understand how to configure Okta. Once the configuration is set, run the standard `mkectl apply` command with your config file and wait for the cluster to be ready.

## Configuring Okta

Create a new application in Okta and use the following settings:

1. Sign-in method: OIDC - OpenID Connect
2. Application Type: Web Application
3. App integration name: Any name you can remember
4. The host for your redirect URLs
   Sign-in redirect URIs: http://{host}/login
   Sign-out redirect URIs: http://{host}
5. Save

Okta will generate the secret and clientID on the `General` table of the application. Use these in your MKE4 config.

## Authentication Flow

Do the following in the browser to test the authentication flow:

1. Navigate to `http://<MKE4 cluster external hostname>:5555/login`
2. Click the `Login` button
3. On the login page, select "Log in with OIDC"
4. You will be redirected to the IdP's login page. Enter your credentials and click `Sign In`
5. Successful authentication will redirect you back to client applications home page
