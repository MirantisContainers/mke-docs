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
| `issuer`       | OIDC provider root URL.                                      |
| `clientID`     | ID from the IdP application configuration.                           |
| `clientSecret` | Secret from the IdP application configuration.                       |
| `redirect URI` | URI to which the provider will return successful authentications. |

OIDC example configuration:

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

**To create a new application in Okta:**

Create a new application in Okta and use the following settings:

1. Select **OIDC - OpenID Connect** for **Sign-in method**.
2. Select **Web Application** for **Application Type**.
3. For **App integration name**, choose a name that you can easily remember.
4. Configure the host for your redirect URLs:
   - Sign-in redirect URIs: `http://{MKE hostname}/login`
   - Sign-out redirect URIs: `http://{MKE hostname}`
5. Click **Save** to generates the `clientSecret` and `clientID` in the `General` table of
the application.
6. Add the generated `clientSecret` and `clientID` values to your MKE configuration file.

Okta will generate the `clientSecret` and `clientID` on the `General` table of
the application. Add the generated values to your MKE 4 config.

Once the configuration is set, run the `mkectl apply` command with your config 
file and wait for the cluster to be ready.

**To test the Authentication flow:**

---
***Note***

"To test authentication flow, ports `5556` (dex) and `5555` (example-app) must be externally available. 

---

In the browser, perform the following steps to test the authentication flow:

1. Navigate to `http://{MKE hostname}:5555/login`
2. Click **Login** to display the login page.
3. Select **Log in with OIDC**.
4. Enter your credentials and click **Sign In**. If authentication is successful, you will be redirected to the client applications home page.
5. Successful authentication will redirect you back to the client applications home page.
