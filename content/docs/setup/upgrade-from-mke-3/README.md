# Upgrade from MKE 3 to MKE 4

This document describes how to upgrade from MKE 3 to MKE 4.

## Prerequisites

Before you begin the upgrade process, ensure that you have the following:

- A running MKE 3.7.x cluster.
```shell
kubectl get nodes
```
```shell
NAME                                           STATUS   ROLES    AGE     VERSION
ip-172-31-103-202.us-west-2.compute.internal   Ready    master   7m3s    v1.27.7-mirantis-1
ip-172-31-104-233.us-west-2.compute.internal   Ready    master   7m3s    v1.27.7-mirantis-1
ip-172-31-191-216.us-west-2.compute.internal   Ready    <none>   6m59s   v1.27.7-mirantis-1
ip-172-31-199-207.us-west-2.compute.internal   Ready    master   8m4s    v1.27.7-mirantis-1
```
- The latest `mkectl` binary installed on your local enviroment.
```shell
mkectl version
```
```shell
Version: v0.0.5
```
- `k0sctl` version `0.17.4` installed on your local enviroment.
```shell
k0sctl version
```

```shell
version: v0.17.4
commit: 372a589
```
- Create a `hosts.yaml` file that describes information needed by `mkectl` to connect to each node via ssh. This is needed to perform an upgrade. An example file is shown below:

```shell
cat hosts.yaml
```

```shell
hosts:
  - address: <host1-external-ip>
    port: <ssh-port>
    user: <ssh-user>
    keyPath: <path-to-ssh-key>
  - address: <host2-external-ip>
    port: <ssh-port>
    user: <ssh-user>
    keyPath: <path-to-ssh-key>
```


## Perform the Upgrade

Users can upgrade from MKE 3 to MKE 4 using the `mkectl` tool. The `mkectl` tool automates the upgrade process by performing the following steps:
- Perform pre upgrade checks to verify that the cluster can be upgraded.
- Perfom pre upgrade migrations to prepare the cluster for a migration from hyperkube based MKE 3 cluster to k0s based MKE 4 cluster.
- Migrate manager nodes to k0s.
- Migrate worker nodes to k0s.
- Perform post upgrade cleanup to remove MKE 3 components.
- Output the new MKE 4 config file.

To upgrade an MKE 3 cluster, run the following command:

```shell
mkectl upgrade --hosts-path <path-to-hosts-yaml> --admin-username <admin-username> --admin-password <admin-password>
```

> If you don't specify `--config-out` flag, the MKE 4 config file will be printed to the console 
after the migration is complete. You can save this output to a file for future use with `mkectl apply`.
<br>Alternatively, you can set `--config-out` to the path where you want to save the MKE 4 config file.

- The upgrade process will take some time to complete. After the upgrade is complete, verify that the MKE 4 cluster is running:

```shell
sudo k0s kc get nodes
```
```shell
NAME                                           STATUS   ROLES    AGE   VERSION
ip-172-31-103-202.us-west-2.compute.internal   Ready    master   29m   v1.29.3+k0s
ip-172-31-104-233.us-west-2.compute.internal   Ready    master   29m   v1.29.3+k0s
ip-172-31-191-216.us-west-2.compute.internal   Ready    <none>   29m   v1.29.3+k0s
ip-172-31-199-207.us-west-2.compute.internal   Ready    master   30m   v1.29.3+k0s
```

- The MKE 3 cluster will no longer be accessible via the previously created client bundle:
```shell
kubectl get nodes
```
```shell
Error from server (Forbidden): nodes is forbidden: User "admin" cannot list resource "nodes" in API group "" at the cluster scope
```

- The docker swarm cluster will no longer be accessible:
```shell
docker service ls
```
```shell
Error response from daemon: This node is not a swarm manager. Use "docker swarm init" or "docker swarm join" to connect this node to swarm and try again.
```

## Upgrade failures

In case an upgrade fails for any reason, the `mkectl` tool automatically rolls back the upgrade process. The rollback process will restore the MKE 3 cluster to its original state.