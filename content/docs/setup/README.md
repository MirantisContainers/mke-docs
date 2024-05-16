# Install MKE 4 CLI

- `mkectl` - The MKE 4 CLI tool, available to download from the
  [Releases](https://github.com/MirantisContainers/mke/releases) page of the MKE 4 repository.

`mkectl` is supposed to be a single binary capable of managing MKE 4 clusters without any additional dependencies.
However, as of commit `e19af33`, it still requires the following tools to be installed on your system:

- `kubectl` of version `1.29.0` or above ([download](https://kubernetes.io/docs/tasks/tools/#kubectl))
- `k0sctl` of version `0.17.0` or above ([download](https://github.com/k0sproject/k0sctl/releases))
