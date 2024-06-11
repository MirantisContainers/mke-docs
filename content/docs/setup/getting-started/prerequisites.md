# Prerequisites

---

***Note***

The prerequisites detailed herein apply only to the Alpha 1.0 pre-release version of MKE 4.

---

## System requirements for cluster nodes

MKE 4 uses [k0s](https://k0sproject.io/) as the underlying Kubernetes
distribution. To learn the k0s hardware requirements, refer to the [k0s
documentation](https://docs.k0sproject.io/v1.29.4+k0s.0/system-requirements/).

## Known limitations

Before installing MKE 4 Alpha 1.0, you should be aware of the current known
limitations of the software.

### Operating systems

Currently, MKE 4 is only certified for use on the following distributions:

- Ubuntu 22.04 Linux
- Ubuntu 20.04 Linux

Windows nodes are **not supported**.

### Architecture

MKE 4 only supports `amd64` architecture.

### CNI

`calico` is the only CNI plugin that MKE 4 supports.

### mkectl

`mkectl`, the [MKE CLI tool](install-mke4-cli.md), must be installed prior to
MKE 4 installation.
