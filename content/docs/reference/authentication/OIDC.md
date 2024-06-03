# OIDC

OpenID Connect (OIDC) can be configured in the `authentication` section of
the Mirantis Kubernetes Engine (MKE) 4 config.
OIDC is disabled by default, to enable it set `enabled` to `true`.

The remaining fields in the `authentication.oidc` section are used to configure
the OIDC provider. Refer to [Configure Okta](#configure-okta) for
instructions on how to obtain the field values.

The following table details the fields that you can configure in the
`authentication.oidc` section of the MKE 4 config:

| Field          | Description                                                                |
|----------------|----------------------------------------------------------------------------|
| `issuer`       | The root URL of the OIDC provider.                                         |
| `clientID`     | The ID from the IdP's application configuration.                           |
| `clientSecret` | The secret from the IdP's application configuration.                       |
| `redirect URI` | The URI that the provider will be returning successful authentications to. |

An example configuration for OIDC:

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

## Configure Okta

Create a new application in Okta and use the following settings:

1. Select **OIDC - OpenID Connect** as the sign-in method.
2. Select **Web Application** as the application type.
3. Choose an app integration name that you can easily remember.
4. The host for your redirect URLs:
   - Sign-in redirect URIs: `http://{MKE hostname}/login`
   - Sign-out redirect URIs: `http://{MKE hostname}`
5. Click **Save**.

Okta will generate the `clientSecret` and `clientID` on the `General` table of
the application. Add the generated values to your MKE 4 config.

Once the configuration is set, run the `mkectl apply` command with your config 
file and wait for the cluster to be ready.

## Authentication flow

---
***Testing tip***

Ports `5556` (dex) and `5555` (example-app) need to be available 
externally to test the authentication flow.

---

In the browser, perform the following steps to test the authentication flow:

1. Navigate to `http://{MKE hostname}:5555/login`
2. Click **Login**.
3. On the login page, select **Log in with OIDC**.
4. You will be redirected to the IdP's login page. Enter your credentials and click **Sign In**.
5. Successful authentication will redirect you back to the client applications home page.
