# Migrate configuration

In migrating to MKE 4 from MKE 3, you can directly transfer settings by passing
several options to `mkectl`.

**To convert a local MKE 3 configuration for MKE 4:**

Set the `--mke3-config` flag to convert a downloaded MKE 3 configuration file into
a valid MKE 4 configuration file, as follows:

```bash
mkectl init --mke3-config /path/to/mke3-config.toml
```
