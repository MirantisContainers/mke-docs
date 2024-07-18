---
title: Create a cluster
weight: 3
---

## Install dependecies

Verify that you have installed `mkectl` and other dependencies on your system
as described in [Install MKE CLI](../install-mke-cli).

## Configure cluster nodes

Configure the cluster nodes in advance, in accordance with the [System
requirements](../system-requirements).

Node provisioning is managed by the cluster administrators. You can, for
instance, use Terraform to create the nodes in a cloud provider.
Refer to [Example Terraform configuration](../../tutorials/k0s-in-aws/terraform-scenario)
for an example.

## Initialize deployment

MKE streamlines the cluster deployment through the use of a single YAML file, which
details the desired cluster configuration. This approach simplifies the setup
process and ensures consistency in cluster deployments.

{{< details title="Example: A ready-to-deploy MKE configuration file" closed="true" >}}

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
     externalAddress: mke.example.com
     sans: []
   ingressController:
     enabled: true
     replicaCount: 2
     extraArgs:
       httpPort: 80
       httpsPort: 443
       enableSslPassthrough: false
       defaultSslCertificate: mke/auth-https.tls
   monitoring:
     enableGrafana: true
     enableOpscare: false
   network:
     kubeProxy:
       disabled: false
       mode: iptables
       metricsbindaddress: 0.0.0.0:10249
       iptables:
         masqueradebit: null
         masqueradeall: false
         localhostnodeports: null
         syncperiod:
           duration: 0s
         minsyncperiod:
           duration: 0s
       ipvs:
         syncperiod:
           duration: 0s
         minsyncperiod:
           duration: 0s
         scheduler: ""
         excludecidrs: []
         strictarp: false
         tcptimeout:
           duration: 0s
         tcpfintimeout:
           duration: 0s
         udptimeout:
           duration: 0s
       nodeportaddresses: []
     nllb:
       disabled: true
     cplb:
       disabled: true
     providers:
       - provider: calico
         enabled: true
         CALICO_DISABLE_FILE_LOGGING: true
         CALICO_STARTUP_LOGLEVEL: DEBUG
         FELIX_LOGSEVERITYSCREEN: DEBUG
         clusterCIDRIPv4: 192.168.0.0/16
         deployWithOperator: false
         enableWireguard: false
         ipAutodetectionMethod: null
         mode: vxlan
         overlay: Always
         vxlanPort: 4789
         vxlanVNI: 10000
         windowsNodes: false
       - provider: kuberouter
         enabled: false
         deployWithOperator: false
       - provider: custom
         enabled: false
         deployWithOperator: false
   ```

{{< /details >}}

1. Generate the YAML file for your installation:

   ```shell
   mkectl init > mke.yaml
   ```

2. In the generated configuration file:

   - Edit the `hosts` section to match your roster of nodes. Provide the SSH
     information for each cluster node, as well as the role of the node based
     on their functions within the cluster. The table below provides the list
     of available node roles and their descriptions:

     | Node Role             | Description                                                                                     |
     |-----------------------|-------------------------------------------------------------------------------------------------|
     | **controller+worker** | A manager node that runs both control plane and data plane components. This role combines the responsibilities of managing cluster operations and executing workloads. |
     | **worker**            | A worker node that runs the data plane components. These nodes are dedicated to executing workloads and   handling the operational tasks assigned by the control plane. |
     | **single**            | A special role used when the cluster consists of a single node. This node handles both control plane and data plane components, effectively managing and executing workloads within a standalone environment. |

   - Specify the external address in the in `apiServer.externalAddress` field.
     The external address is the domain name of the load balancer configured
     as described in [System Requirements: Load balancer](../system-requirements#load-balancer-requirements).  

## Create a cluster

1. Verify that there are no existing MKE clusters. You must not attempt to create
   a new cluster until you have first deleted the existing cluster. If you do make
   such an attempt, even through the use of a different configuration file, you will
   permanently lose access to the first cluster through `mkectl`.
   
   For information on how to delete a cluster, refer to [Uninstall a cluster](../uninstall-cluster).

2. Create a new cluster using `mkectl apply` command with the generated YAML
   configuration file:

   ```shell
   mkectl apply -f mke.yaml
   ```

   {{< callout type="warning" >}}

   The `mkectl apply` command configures the `mke` context in the default kubeconfig
   file located at `~/.kube/config`. If the default kubeconfig is changed, and the `mke`
   context becomes invalid or unavailable, `mkectl` will not manage the cluster until
   the kubeconfig is restored.

   {{< /callout >}}

Now, you can start interacting with the newly created cluster using `kubectl` with
the `mke` context.
