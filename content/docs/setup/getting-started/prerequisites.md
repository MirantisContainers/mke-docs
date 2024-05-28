## Prerequisites

### System requirements for cluster nodes

MKE 4 uses [k0s](https://k0sproject.io/) as the underlying Kubernetes
distribution. To learn the k0s hardware requirements, refer to the [k0s
documentation](https://docs.k0sproject.io/v1.29.4+k0s.0/system-requirements/).

### Known limitations

#### Operating systems

Currently, MKE 4 is only certified for use on the Ubuntu 20.04 Linux
distribution.

Windows nodes are **not supported**.

#### Architecture

MKE 4 only supports `amd64` architecture.

#### CNI

`calico` is the only CNI plugin that MKE 4 supports.
