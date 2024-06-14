# Uninstallation

Run the `reset` command to destroy the cluster that was previously created with
the `apply` command.

```shell
mkectl reset -f mke.yaml
```

You will be prompted to confirm the deletion of the cluster. To
skip this step, use the `--force` flag with the `reset` command.
