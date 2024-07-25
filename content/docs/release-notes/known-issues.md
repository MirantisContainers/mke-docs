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
