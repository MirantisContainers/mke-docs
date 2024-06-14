# Create a cluster

## Dependencies

A number of tools must be installed on your system before you can install MKE
4:

- mkectl
- k0sctl
- kubectl

Refer to [Install the MKE 4 CLI](install-mke4-cli.md) for detailed information.

## Initialization

MKE 4 installation is performed through the use of a single YAML file,
detailing the desired cluster configuration. To generate this YAML file, run
the `mkectl init` command:

```shell
mkectl init > mke.yaml
```

In the configuration file, edit the `hosts` section to match your roster
of nodes.

---
***Note***

Configure the cluster nodes in advance, in accordance with the [system
  requirements](prerequisites.md#system-requirements-for-cluster-nodes).

Node provisioning is managed by the cluster administrators. You can, for
instance, use Terraform to create the nodes in a cloud provider.
[Example
Terraform configuration](k0s-in-aws/terraform-scenario.md).

---

You must provide SSH information for each cluster node, as well as the role of
the node:

<dl>
  <dt>controller+worker</dt>
  <dd>A manager node that runs both control plane and data plane components.</dd>
  <dt>worker</dt>
  <dd>A worker node that runs the data plane components.</dd>
  <dt>single</dt>
  <dd>A special role, for use when the cluster consists of a single node.</dd>
</dl>

<details>
<summary>Example: A ready-to-deploy MKE 4 config file</summary>

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

## Installation

To perform the installation, run the `apply` command with the generated YAML
configuration file:

```shell
mkectl apply -f mke.yaml
```

## Known limitations

- `mkectl apply` configures `mke` context in the default kubeconfig file that
is located at `~/.kube/config`. If the default kubeconfig is changed,
and the `mke` context becomes invalid or unavailable, `mkectl` will be unable
to manage the cluster until the kubeconfig is restored.
- You must not attempt to create a new cluster until you have first deleted the
existing cluster. If you do make such an attempt, even through the use of a
different config file, you will permanently lose access to the first cluster
through `mkectl`. For information on how to delete a cluster, refer to
[Uninstallation](uninstallation.md).
