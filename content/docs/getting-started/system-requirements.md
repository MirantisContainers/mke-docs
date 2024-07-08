---
title: System requirements
weight: 1
---

Before you start cluster deployment, verify that your system meets the following minimum hardware
and software requirements.

## Hardware requirements

MKE uses [k0s](https://k0sproject.io/) as the underlying Kubernetes
distribution. To learn the k0s hardware requirements, refer to the [k0s
documentation](https://docs.k0sproject.io/v1.29.4+k0s.0/system-requirements/).

## Software requirements

- Operating systems:
  - Ubuntu 22.04 Linux
  - Ubuntu 20.04 Linux
- Architecture: `amd64`
- CNI: Calico

## Load Balancer requirements

In order for MKE Dashboard to function properly, MKE 4 requires a TCP load balancer,
which acts as a single point of contact to access the controllers.
The load balancer needs to allow and route traffic to each controller through the following ports:

| Listen Port | Target Port | Purpose             |
|-------------|-------------|---------------------|
| 6443        | 6443        | Kubernetes API      |
| 8132        | 8132        | Konnectivity        |
| 9443        | 9443        | Controller join API |
| 443         | 33001       | MKE Dashboard       |

The listen port of the MKE Dashboard can be different from 443, but in this case, you must append the listen port
to the external address in the configuration file. E.g. if you set listen port to be the same as the target port, 33001,
the configuration would look as follows

```yaml
apiServer:
  externalAddress: "mke.example.com:33001"
```

The load balancer can be implemented in many different ways and MKE 4 doesn't have any additional requirements.
You can use for example HAProxy, NGINX or your cloud provider's load balancer.
