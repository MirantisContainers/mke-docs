# Using the cluster

You can use `kubectl` with the `mke` context to interact with the cluster,
though it is necessary to specify the configuration. `mkectl` outputs the
kubeconfig of the cluster to `~/mke/.mke.kubeconfig`.

You can apply ``.mke.kubeconfig`` using any one of the following methods:

- Set the KUBECONFIG env var to point to `~/.mke/mke.kubeconfig`

  ```shell
  export KUBECONFIG=~/.mke/<cluster name>.kubeconfig
  ```

- Append the contents to the default kubeconfig:

  ```shell
  cat ~/.mke/mke.kubeconfig >> ~/.kube/config
  ```

- Specify the config as a command argument:

  ```shell
  kubectl --kubeconfig ~/.mke/mke.kubeconfig
  ```

Example output:

```text
$ kubectl --context mke get nodes
NAME    STATUS   ROLES           AGE   VERSION
node1   Ready    <none>          2d    v1.29.3+k0s
node2   Ready    control-plane   2d    v1.29.3+k0s
```

To modify the cluster configuration, edit the YAML configuration file and
rerun the `apply` command.

```shell
mkectl apply -f mke.yaml
```
