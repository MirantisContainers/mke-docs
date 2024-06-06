# Known issues

MKE 4 Alpha.1 known issues with available workarounds include:

## [BOP-694] MKE 3 upgrade rollback destabilizes the cluster

When a rollback to MKE 3 occurs as the result of an upgrade issue, the MKE
cluster is inaccessible through the MKE web UI address and ``ucp-auth``
containers continually restart.

**Workaround:** Uninstall MKE 3 and restore it from a backup.

## [BOP-708] RBAC resource creation fails during mkectl upgrade when OIDC enabled

During a mkectl upgrade from MKE 3, RBAC resource creation fails when OIDC is
enabled.

**Workaround:**

1. Copy the MKE 4 config that prints at the end of migration.

   Example:

   ```
   INF Below is your new MKE 4 config. Save it to a file and use it to configure the MKE 4 cluster with mkectl apply:
   ```

2. Update the ``authentication.oidc.clientSecret`` field to the secret field
   from your identity provider.

3. Apply the updated MKE 4 config.

## [BOP-686] In MKE 3 upgrade, kubectl commands return "No agent available"

Following an upgrade from MKE3, kubectl commands such as `exec` and `logs`
return ``No agent available``.

**Workaround:**
