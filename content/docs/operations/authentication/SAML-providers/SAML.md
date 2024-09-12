---
title: SAML
weight: 3
---

You can configure SAML (Security Assertion Markup Language) for MKE 4 through
the `authentication` section of the MKE configuration file. To enable the
service, set `enabled` to `true`. The remaining fields in the
`authentication.saml` section are used to configure the SAML provider. For
information on how to obtain the field values, refer to your chosen provider:

- [Okta](../SAML-providers/SAML-OKTA-configuration)

For more information, refer to the official DEX documentation
[Authentication through SAML 2.0](https://dexidp.io/docs/connectors/saml/).

## Configure MKE

The MKE configuration file `authentication.smal` fields are detailed below:

| Field                             | Description                                                                                                                                                                         |
|-----------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `enabled`                         | Enable authentication through dex.                                                                                                                                                  |
| `ssoMetadataURL`                  | Metadata URL provided by some IdPs, with which MKE can retrieve information for all other SAML configurations.<br><br>When a URL is provided for `ssoMetadataURL`, the other SAML fields are not required.                                                                       |
| `ca`                              | Certificate Authority (CA) alternative to `caData` to use when validating the signature of the SAML response. Must be manually mounted in a local accessible by dex. |
| `caData`                          | CA alternative to `ca`, which you can use to place the certificate data directly into the config file.                                                                |
| `ssoURL`                          | URL to provide to users to sign into MKE 4 with SAML. Provided by the IdP.                                                                                                          |
| `redirectURI`                     | Callback URL for dex to which users are returned to following successful IdP authentication.                                                                                        |
| `insecureSkipSignatureValidation` | Optional. Use to skip the signature validation. For testing purposes only.                                                                                                          |
| `usernameAttr`                    | Username attribute in the returned assertions, to map to ID token claims.                                                                                                           |
| `emailAttr`                       | Email attribute in the returned assertions, to map to ID token claims.                                                                                                              |
| `groupsAttr`                      | Optional. Groups attribute in the returned assertions, to map to ID token claims.                                                                                                   |
| `entityIssuer`                    | Optional. Include as the Issuer value during authentication requests.                                                                                                               |
| `ssoIssuer`                       | Optional. Issuer value that is expected in the SAML response.                                                                                                                       |
| `groupsDelim`                     | Optional. If groups are assumed to be represented as a single attribute, this delimiter splits the attribute value into multiple groups.                                            |
| `nameIDPolicyFormat`              | Requested name ID format.                                                                                                                                                           |

### Example SAML configuration:

```yaml
authentication:
  enabled: true
  saml:
    enabled: true
    ssoURL: https://dev64105006.okta.com/app/dev64105006_mke4saml_1/epkdtszgindywD6mF5s7/sso/saml
    redirectURI: http://{MKE host}:5556/callback
    usernameAttr: name
    emailAttr: email
```

## Use `ssoMetadataURL` ##

You can retrieve information for all of the SAML configurations in your MKE
cluster by accessing the URL configured to `ssoMetadataURL` in the MKE
configruation file.

Example of information provided when you access the `ssoMetadataURL` URL:

```shell
<md:EntityDescriptor xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata" entityID="http://www.okta.com/exk75pi5do2MzU1t95r7">
<md:IDPSSODescriptor WantAuthnRequestsSigned="false" protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
<md:KeyDescriptor use="signing">
<ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
<ds:X509Data>
<ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAYRZVRraMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG A1UECAwKQ2FsaWZvcm5pYTeWMBQGA1UEBwwNU2FuIEZyYW5jaXNjszENMAsGA1UECgwET2t0YTEU MBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi02NDEwNTAwNjEcMBoGCSqGSIb3DQEJ ARYNaW5mb0Bva3RhLmNvbTAeFw0yMjExMDgyMjIwMDBaFw0zMjExMDgyMjIxMDBaMIGUMQswCQYD VQQGEwJVUzETMBEGA1UECAwKQ2FsaWevcmcpYTEqMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG A1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi02NDEwNTAwNjEc MBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCdSIwDQYJKoZIhvcNAcEBBQADggEPADCCAQoC ggEBAMBMAL7j8+FckMRBx9nIllViMRF8Ah/Gfxnjm4r3LqSdAkMnG4lch7jPNxwy43oOzeO55Ee2 oOqO5RyY0LxhNhGgITzMU1l/I7j6Z/T845aaoadkFe6AHr4sA1PWquw7fPRIgVhDJUbBvtPwf8SI +ncMSkoulQ+FitheN8n+o/7obEfKQxvSbdTudDZgPtPAY2G9VMjhYVnwked9u8ZrAj3IckS6UWlB WV/BG/XDn2wawuQco2/sR3qhUi6cvIpXtSkArW4LCqp2PZH/ItgaTSR+UjfiIaQQBUvUq2E2JGO6 SiuGWjNHGo6+S0cT2rgkTKSqLzjME9BeSw9J45HtmY0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA LoOtDbvh9vQdCpjZ4enLdBBls2cIr7/YRl43Sv0MGcckQYwOk9OZg9uuMsUJTp6fkbjy1kBfbj7R ZSqNTtQGMs8V30kxCfpxFOBUOm6f/pKJvGqkDjOXMLaWMuwM+j//LYw8N9EIEnH8aN4e7sitHL3L ORpQ8I+M9lRUATgzUaz59dLNHHO9sg5ikDE2kL84U9nQAMDXc+vsUordGRUotVlvIuXT8Hv63OSS akpuYR4Jx9l9XV4nOufhmAZh2dKJKd7c+wlQuJNL+xBEax2F6qQfCjzLEnWEx5wt3vT0EtCGLBOU ZIBHiRNuPYueZ9PdRkpWJpscyjZsfbgzhMCbRg==</ds:X509Certificate>
</ds:X509Data>
</ds:KeyInfo>
</md:KeyDescriptor>
<md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat>
<md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat>
<md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://dev-64105006.okta.com/app/dev-63105106_mke_2/exk75pi5do2MzU1t95r7/sso/saml"/>
<md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" Location="https://dev-63105106.okta.com/app/dev-63105106_mke_2/exk75pi5do2MzU1t95r7/sso/saml"/>
</md:IDPSSODescriptor>
</md:EntityDescriptor>
```

## Test authentication flow

{{< callout type="info" >}}
  To test authentication flow, ports `5556` (dex) and `5555` (example-app) must be externally available.
{{< /callout >}}

1. Navigate to `http://{MKE hostname}:5555/login`.
2. Click **Login** to display the login page.
3. Select **Log in with SAML**.
4. Enter your credentials and click **Sign In**. If authentication is successful,
you will be redirected to the client applications home page.
