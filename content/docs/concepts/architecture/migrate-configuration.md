# Migrate configuration

If you migrate from MKE 3, you can pass some options to `mkectl` to transfer 
the settings directly from MKE 3.

**Convert local MKE 3 config**

To pass in a downloaded MKE 3 configuration file set the `--mke3-config` flag. 
This will convert the local MKE 3 config into a valid MKE 4 config.

```bash
mkectl init --mke3-config /path/to/mke3-config.toml
```
