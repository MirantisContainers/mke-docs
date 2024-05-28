

## Using the cluster

You can use `kubectl` with the `mke` context to interact with the cluster.

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
