# Known issues

Workaround solutions are available for the following MKE 4 Alpha.1 known
issues:

## [BOP-694] MKE 3 upgrade rollback destabilizes the cluster

When a rollback to MKE 3 occurs as the result of an upgrade issue, the MKE
cluster is inaccessible through the MKE web UI address and ``ucp-auth``
containers continually restart.

**Workaround:** Uninstall MKE 3 and restore it from a backup.

## [BOP-708] OIDC authenticaion fails after mkectl upgrade

Due to an issue with client secret migration, OIDC authentication fails
following an upgrade performed with mkectl.

**Workaround:**

1. Copy the MKE 4 config that prints at the end of migration.

2. Update the ``authentication.oidc.clientSecret`` field to the secret field
   from your identity provider.

3. Apply the updated MKE 4 config.

## [BOP-686] In MKE 3 upgrade, kubectl commands return ``No agent available``

For a cluster with multiple controller nodes (manager/master nodes), [k0s
requires the presence ofa load balancer for the controller
node](https://docs.k0sproject.io/head/high-availability/ ). Without a load
balancer, the controller nodes is unable to reach the kubelet on the worker
nodes, and thus the user will be presented with ``No agent available`` errors.

**Workaround:**

1. If an external load balancer is not already in place, create one that
   targets all controllers and that forwards the following ports:

   - `443`, for controller
   - `6443`, for Kubernetes API
   - `8132`, for Konnectivity

2. Use `k0sctl` to update the `k0s` config to set `externalAddress`:

   ```
   k0s:
     config:
       spec:
         api:
           externalAddress: <load balancer public ip address>
           sans:
           - <load balancer public ip address>
   ```
