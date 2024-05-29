# Upgrade from MKE 3 to MKE 4

## Prerequisites

Verify that you have the following components in place before you begin the upgrade process:

- A running MKE 3.7.x cluster:

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
- The latest `mkectl` binary, installed on your local enviroment:

  ```shell
  mkectl version
  ```
  ```shell
  Version: v0.0.5
  ```

- `k0sctl` version `0.17.4`, installed on your local enviroment:

  ```shell
  k0sctl version
  ```

  ```shell
  version: v0.17.4
  commit: 372a589
  ```
- A `hosts.yaml` file, to provide the information required by `mkectl` to
  connect to each node by way of SSH.

  Example `hosts.yaml` file:

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
