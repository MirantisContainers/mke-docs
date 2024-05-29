# Install MKE 4 CLI

- `mkectl` - The MKE 4 CLI tool, available to download from the
  [Releases](https://github.com/MirantisContainers/mke/releases) page of the MKE 4 repository.

`mkectl` is supposed to be a single binary capable of managing MKE 4 clusters without any additional dependencies.
However, as of commit `e19af33`, it still requires the following tools to be installed on your system:

- `kubectl` of version `1.29.0` or above ([download](https://kubernetes.io/docs/tasks/tools/#kubectl))
- `k0sctl` of version `0.17.0` or above ([download](https://github.com/k0sproject/k0sctl/releases))

# Installation via script

You can use the [installation script](./install.sh) to install the following dependencies.
- mkectl (default version: v4.0.0-alpha.0.3)
- k0sctl (default version: 0.17.8)
- kubectl (default version: v1.30.0)

To override the default versions, you can pass the variables `K0SCTL_VERSION`,`MKECTL_VERSION`and `KUBECTL_VERSION`.


### Usage

1. Copy the [installation script](./install.sh) on your machine.

2. Change the access permissions by running this command.
    ```shell
    chmod +x install.sh
    ```

3. Execute the script by running the following command.
    ```shell
      sudo ./install.sh
    ```

    P.S. Mac users might also be prompted for the password.


4. The script is designed to detect the os and the underlying architecture. Based on this, it shall install the appropriate binaries 'k0sctl', 'kubectl and 'mkectl' in /usr/local/bin.
   ```markdown
   Note: Make sure /usr/local/bin is in your PATH environment variable.
   ```
   
5. Confirm by running

   a. _mkectl version command_

    ```shell
      mkectl version
    ```
   Output:
   ```shell
      Version: v4.0.0-alpha.0.3
    ```
   b. _k0sctl version command_
    ```shell
      k0sctl version
    ```
   Output:
   ```shell
      version: v0.17.8
      commit: b061291
    ```
   c. _kubectl version command_
    ```shell
      kubectl version
    ```
   Output:
   ```shell
      Client Version: v1.30.0
      Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
      Server Version: v1.29.3+k0s
    ```
   
### Debug mode
To turn the debug mode on, run
```shell
sudo DEBUG=true ./install.sh
```

### Install different version
To install non-default versions of mkectl, kubectl and k0sctl, you can use `MKECTL_VERSION`, `KUBECTL_VERSION` and `K0SCTL_VERSION` respectively.

Example usage:
```shell
sudo K0SCTL_VERSION=0.17.4 ./install.sh
```

This shall install k0sctl version 0.17.4. 
```shell
k0sctl version

version: v0.17.4
commit: 372a589
```

