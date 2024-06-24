# Install the MKE 4 CLI

You can download `mkectl`, the MKE CLI tool, from the S3 bucket:

- [Linux arm64 image](https://s3.us-east-2.amazonaws.com/packages-stage-mirantis.com/v4.0.0-alpha1.0/mkectl_linux_arm64.tar.gz)
- [Linux x86_64 image](https://s3.us-east-2.amazonaws.com/packages-stage-mirantis.com/v4.0.0-alpha1.0/mkectl_linux_x86_64.tar.gz)
- [MacOS arm64 image](https://s3.us-east-2.amazonaws.com/packages-stage-mirantis.com/v4.0.0-alpha1.0/mkectl_darwin_arm64.tar.gz)
- [MacOS x86_64 image](https://s3.us-east-2.amazonaws.com/packages-stage-mirantis.com/v4.0.0-alpha1.0/mkectl_darwin_x86_64.tar.gz)
- [Windows arm64 image](https://s3.us-east-2.amazonaws.com/packages-stage-mirantis.com/v4.0.0-alpha1.0/mkectl_windows_arm64.zip)
- [Windows x86_64 image](https://s3.us-east-2.amazonaws.com/packages-stage-mirantis.com/v4.0.0-alpha1.0/mkectl_windows_x86_64.zip)

Envisioned as a single binary, capable of managing MKE 4 clusters without any
additional dependencies, as of `MKE 4.0.0-alpha.1.0` the MKE CLI requires
that you have the following tools installed on your system:

- `kubectl`, version `1.29.0` or later ([download](https://kubernetes.io/docs/tasks/tools/#kubectl))
- `k0sctl`, version higher or equal to `0.17.0` but less than `0.18.0` ([download](https://github.com/k0sproject/k0sctl/releases))

## Install using a script

You can use the [install.sh](../install.sh) script to install the following
dependencies:

- `mkectl` (default version: v4.0.0-alpha.0.3)
- `k0sctl` (default version: 0.17.8)
- `kubectl` (default version: v1.30.0)

To override the default versions, pass the variables
`K0SCTL_VERSION`,`MKECTL_VERSION`and `KUBECTL_VERSION`.

---
***Note***

The `install.sh` script detects whether `kubectl` is already installed on your
system and will not overwrite it. It also detects the operating system and the
underlying architecture, based on which it will install the `k0sctl`, `kubectl`
and `mkectl` binaries in `/usr/local/bin`. Thus, you must ensure that
` /usr/local/bin` is in your PATH environment variable.

---

1. Install the dependencies:

   ```shell
   sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mirantis/mke-docs/main/content/docs/setup/install.sh)"
    ```

2. Confirm dependency installations:

   1. To confirm `mkectl`, run:

      ```shell
      mkectl version
      ```

      Expected output:

      ```shell
      Version: v4.0.0-alpha.1.0
      ```

   2. To confirm `k0sctl`, run:

      ```shell
      k0sctl version
      ```

      Expected output:

      ```shell
      version: v0.17.8
      commit: b061291
      ```

   3. To confirm `kubectl`, run:

      ```shell
      kubectl version
      ```

      Expected output:

      ```shell
      Client Version: v1.30.0
      Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
      Server Version: v1.29.3+k0s
      ```

### Start Debug mode

To turn the debug mode on, run:

```shell
sudo DEBUG=true /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Mirantis/mke-docs/main/content/docs/setup/install.sh)"
```

### Install different dependency versions

You can use the `MKECTL_VERSION`, `KUBECTL_VERSION` and `K0SCTL_VERSION`
variables to install non-default versions of `mkectl`, `kubectl` and `k0sctl`.

Example:

```shell
sudo K0SCTL_VERSION=0.17.4 /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Mirantis/mke-docs/main/content/docs/setup/install.sh)"
```

Example output:

```shell
k0sctl version

version: v0.17.4
commit: 372a589
```