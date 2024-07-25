---
title: Known issues
weight: 2
---

The MKE 4 known issues with available workarounds are described herein.

## [BOP-708] OIDC authentication fails after mkectl upgrade

Due to an issue with client secret migration, OIDC authentication fails
following an upgrade performed with `mkectl`.

**Workaround:**

1. Copy the MKE 4 configuration that prints at the end of migration.

2. Update the `authentication.oidc.clientSecret` field to the secret field
   from your identity provider.

3. Apply the updated MKE 4 configuration.

## [BOP-898][BOP-899] Calico eBPF and IPVS modes are not supported

Calico eBPF and IPVS mode are not yet supported for MKE 4. As such, upgrading
from an MKE 3 cluster using either of those networking modes results in an
error:

```sh
FATA[0640] Upgrade failed due to error: failed to run step [Upgrade Tasks]: unable to install BOP: unable to apply MKE4 config: failed to wait for pods: failed to wait for pods: failed to list pods: client rate limiter Wait returned an error: context deadline exceeded
```

## [BOP-905] Prometheus dashboard reports incorrect heavy memory use

The Prometheus dashboard displays heavy memory use that does not accurately
reflect true memory status.

## [BOP-947] Managed user passwords are not migrated during upgrade from MKE 3

The `admin` password is migrated during upgrade from MKE 3, however all other
managed user passwords are not migrated.

## [BOP-964] mke-operator in crashloopbackoff status

The mke-operator-controller-manager is in crashloopbackoff status in MKE 4
Alpha 2. You can safely ignore this, however, as it has no effect on MKE
4.0.0-alpha.2.0 functionality.

## [BOP-583] LDAP settings fail to migrate during upgrade from MKE 3

LDAP configurations are not stored in MKE 3 configuration files, and thus they
are not included when you upgrade to MKE 4 from an MKE 3 installation.

**Workaround:**

When upgrading from MKE 3, you must manually add the LDAP configuration.

1. Make a request to ``https://{{host}}/enzi/v0/config/auth/ldap`` on the MKE 3
cluster prior to the migration. For more information, refer to the [MKE 3
LDAP Configuration through API documentation](https://docs.mirantis.com/mke/3.7/ops/administer-cluster/integrate-with-LDAP-directory/configure-ldap-integration.html#ldap-configuration-through-api).

2. Convert the LDAP response to the MKE 4 LDAP settings.
3. Apply the translated LDAP settings to the cluster following migration.