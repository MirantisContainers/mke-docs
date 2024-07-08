---
title: Known issues
weight: 2
---

This section describes the MKE 4 known issues with available workarounds.

## [BOP-708] OIDC authentication fails after mkectl upgrade

Due to an issue with client secret migration, OIDC authentication fails
following an upgrade performed with `mkectl`.

**Workaround:**

1. Copy the MKE 4 configuration that prints at the end of migration.

2. Update the `authentication.oidc.clientSecret` field to the secret field
   from your identity provider.

3. Apply the updated MKE 4 configuration.

## [BOP-879] External Address flag is ignored when upgrading from a 1 manager MKE cluster

When you upgrade a single-manager MKE 3 cluster, the `--external-address` flag is ignored.

**Workaround:**

`mkectl upgrade` command generates an MKE 4 configuration file at the end of the upgrade process.

To set the external address, update the `apiServer.externalAddress` field in the configuration file
with the desired external address

```yaml
apiServer:
  externalAddress: "mke.example.com"
```

Then, run `mkectl apply`.
