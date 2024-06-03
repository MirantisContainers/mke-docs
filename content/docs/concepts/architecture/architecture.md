# MKE Architecture

Mirantis Kubernetes Engine (MKE) 4 is an enterprise-grade, production-ready
Kubernetes platform designed to be secure, scalable, and reliable.
MKE 4 is deployed using an MKE configuration file.
See the [Configuration and blueprints](configuration.md) for more information.

## Components

MKE 4 is built on top of k0s, a lightweight Kubernetes distribution.
See the [official k0s documentation](https://docs.k0sproject.io/v1.29.3+k0s.0/)
for more information.

### Control plane

MKE 4 uses a control plane that oversees crucial cluster-wide decisions,
and monitors and responds to events within the cluster.
While the control plane components can function on any machine in the cluster,
setup scripts streamline the process by running all control plane 
components on one machine and excluding user containers from that machine.

### Container Network Interface 

By default, MKE 4 installs Calico as the Container Network Interface (CNI) plugin with the following configuration:

- IPv4 only with a fixed Pod CIDR of `10.244.0.0/16`.
- The datastore mode is set to `kdd`.
- `kube-proxy` set to `iptables` mode. 
- `vxlan` backend, which uses the default port of `4789` for traffic and default virtual network ID of `4096`.
  
With the Alpha.1 release, MKE 4 has the following limitations:

- There is no option to use a different CNI plugin.
- There is no option to configure Calico from the above defaults.
- When a cluster is upgraded from MKE 3, the Calico configuration is not migrated.

<!-- ### Data Plane -->

<!-- [Discuss the data plane components and their functions] -->

<!-- ## High-Level Diagram -->

<!-- [Include a high-level diagram illustrating the MKE architecture] -->

<!-- ## Deployment considerations -->

<!-- [Highlight any important considerations for deploying MKE] -->

<!-- ## Conclusion [Wrap up the document with a conclusion or summary] -->
