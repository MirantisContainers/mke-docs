# Getting started

## Pre-requisites

### Cluster nodes system requirements

MKE 4 uses [k0s](https://k0sproject.io/) as the underlying Kubernetes distribution. 
Please refer to the [k0s documentation](https://docs.k0sproject.io/v1.29.4+k0s.0/system-requirements/) for the hardware requirements.

### Known limitations

#### Operating systems

Currently, MKE 4 is only tested on Ubuntu 20.04. Stable work on other Linux distributions is not guaranteed.

Windows nodes are currently **not supported**.

#### Architecture

MKE 4 only supports `amd64` architecture.

#### CNI

MKE 4 only supports `calico` as the CNI plugin.

## Installation

### Init

To install MKE 4, all is needed is a single YAML file that describes the desired cluster configuration. 
This file can be generated using the `mkectl init` command:

```shell
mkectl init > mke.yaml
```

In the generated config file, the `hosts` section needs to be edited to match the list of nodes 
that will be used in the cluster.

> The nodes are expected to be created in advance and configured with accordance to the
[system requirements](#cluster-nodes-system-requirements). It's up to the cluster administrators to decide how
to provision the nodes. For instance, [Terraform](https://www.terraform.io/) can be used to create the nodes 
in a cloud provider. Refer to [the example of a possible terraform configuration](k0s-in-aws/README.md).

For each cluster node, SSH information and the role of the node need to be provided.
The roles can be:
- `controller+worker` - a manager node that runs both control plane and data plane components
- `worker` - a worker node that runs the data plane components
- `single` - a special role for the case when the cluster consists of a single node

<details>
<summary>Example of ready-to-deploy MKE 4 config file</summary>

```yaml
hosts:
  - ssh:
      address: 1.1.1.1  # external IP of the first node
      keyPath: /path/to/ssh/key.pem
      port: 22
      user: username
    role: controller+worker
  - ssh:
      address: 2.2.2.2  # external IP of the second node
      keyPath: /path/to/ssh/key.pem
      port: 22
      user: username
    role: worker
hardening:
  enabled: true
authentication:
  enabled: true
  saml:
    enabled: false
  oidc:
    enabled: false
  ldap:
    enabled: false
backup:
  enabled: true
  storage_provider:
    type: InCluster
    in_cluster_options:
      exposed: true
tracking:
  enabled: true
trust:
  enabled: true
logging:
  enabled: true
audit:
  enabled: true
license:
  refresh: true
apiServer:
  sans: ["mydomain.com"]
ingressController:
  enabled: false
monitoring:
  enableGrafana: true
  enableOpscare: false
```

</details>

### Install

To perform the installation, simply run the `apply` command with the generated config file:

```shell
mkectl apply -f mke.yaml
```

### Known limitations

- `mkectl apply` configures `mke` context in the default kubeconfig file normally located at `~/.kube/config`.
If the default kubeconfig is changed, and the `mke` context becomes invalid or unavailable 
`mkectl` will not be able to manage the cluster until the kubeconfig is restored.
- After the cluster is created, you must not attempt creating another cluster until you delete the existing one. 
For deleting the cluster, refer to the [Uninstallation](#uninstallation) section. If you try to create a new cluster,
even with a different config file, `mkectl` will permanently lose the access to the first cluster.

## Using the cluster

You can use `kubectl` with the `mke` context to interact with the cluster.

```text
$ kubectl --context mke get nodes
NAME    STATUS   ROLES           AGE   VERSION
node1   Ready    <none>          2d    v1.29.3+k0s
node2   Ready    control-plane   2d    v1.29.3+k0s
```

To modify the cluster configuration, edit the `mke.yaml` file and run the `apply` command again.

```shell
mkectl apply -f mke.yaml
```

## Uninstallation

The reset command will destroy the cluster that was previously created by the `apply` command.

```shell
mkectl reset -f mke.yaml
```

It will ask for confirmation before proceeding with the deletion. 
Alternatively, you can use the `--force` flag to skip the confirmation.
