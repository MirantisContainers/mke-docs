# Perform the Upgrade

An upgrade from MKE 3 to MKE 4 consists of the following steps, all of which
are performed through the use of the `mkectl` tool:

- Run pre-upgrade checks to verify the upgradability of the cluster.
- Carry out pre-upgrade migrations to prepare the cluster for a migration from
  a hyperkube-based MKE 3 cluster to a k0s-based MKE 4 cluster.
- Migrate manager nodes to k0s.
- Migrate worker nodes to k0s.
- Carry out post-upgrade cleanup, to remove MKE 3 components.
- Output the new MKE 4 config file.

To upgrade an MKE 3 cluster, run the following command:

```shell
mkectl upgrade --hosts-path <path-to-hosts-yaml> --admin-username <admin-username> --admin-password <admin-password>
```

---
***Note***

The MKE 4 config file prints to your console when the migration is complete. To
output the config file to a file for future use, run `mkectl apply`.
Alternatively, you can set the `--config-out` flag to the path where you want
to save the MKE 4 config file.

---

The upgrade process requires time to complete. Once the process is complete,
run the following command to verify that the MKE 4 cluster is operating:

```shell
sudo k0s kc get nodes
```

Example output:

```shell
NAME                                           STATUS   ROLES    AGE   VERSION
ip-172-31-103-202.us-west-2.compute.internal   Ready    master   29m   v1.29.3+k0s
ip-172-31-104-233.us-west-2.compute.internal   Ready    master   29m   v1.29.3+k0s
ip-172-31-191-216.us-west-2.compute.internal   Ready    <none>   29m   v1.29.3+k0s
ip-172-31-199-207.us-west-2.compute.internal   Ready    master   30m   v1.29.3+k0s
```

---

***Note***

The MKE 3 cluster will no longer be accessible through the previously created
client bundle. The docker swarm cluster will no longer be accessible as well.

---

In the event of an upgrade failure, the upgrade process rolls back,
restoring the MKE 3 cluster to its original state.