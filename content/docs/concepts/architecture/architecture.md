# MKE Architecture

## Overview

Mirantis Kubernetes Engine (MKE) 4  is an enterprise-grade, production-ready Kubernetes platform designed to be secure, scalable, and reliable. MKE4 is deployed using an MKE [configuration file](./configuration.md)

## Components

MKE 4 is built on top of k0s, a lightweight Kubernetes distribution. See the [k0s documentation](https://k0sproject.io/docs/) for more information.

MKE 4 Alpha.1 is run on top of k0s v1.29.3. 

### Control Plane [mocny edyt]

The control plane's components make global decisions about the cluster (for example, scheduling), as well as detecting and responding to cluster events (for example, starting up a new pod when a Deployment's replicas field is unsatisfied).

Control plane components can be run on any machine in the cluster. However, for simplicity, setup scripts typically start all control plane components on the same machine, and do not run user containers on this machine.

#### CNI

By default, MKE 4 installs Calico as the CNI plugin. This is done by specifying `calico` in the network provider field of the k0s config.

Calico is installed with the following configuration:

- IPv4 only with a fixed pod CIDR of `10.244.0.0/16`.
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

## Conclusion

[Wrap up the document with a conclusion or summary]
