# MKE Architecture

## Overview

[Provide a brief overview of MKE architecture]

## Components

MKE 4 is built on top of k0s, a lightweight Kubernetes distribution. See the [k0s documentation](https://k0sproject.io/docs/) for more information.

MKE 4 Alpha.1 is run on top of k0s v1.29.3. 

### Control Plane

<[Explain the control plane components and their roles]>

#### CNI

By default, MKE 4 installs Calico as the CNI plugin. 
Alpha.1 release has the following limitations:
- There is no option to use a different CNI plugin.
- There is no option to configure Calico.
- When a cluster is upgraded from MKE 3, the Calico configuration is not migrated.

### Data Plane

[Discuss the data plane components and their functions]

## High-Level Diagram

[Include a high-level diagram illustrating the MKE architecture]

## Deployment Considerations

[Highlight any important considerations for deploying MKE]

## Conclusion

[Wrap up the document with a conclusion or summary]
