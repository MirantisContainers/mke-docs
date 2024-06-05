# Configuration and blueprints

The Mirantis Kubernetes Engine (MKE) 4 configuration file contains an
opinionated configuration on how to set up the MKE cluster.

With the MKE configuration file, you can:

- Define the number of nodes in the cluster.
- Define ways to access the nodes.
- Enable or disable certain MKE 4 features.

Once set, the MKE configuration file is translated into a more complex blueprint
that contains the granular details on how to set up the cluster.

## Create configuration

To generate the default MKE configuration file run `mkectl init > mke.yaml` command.
Next, modify generated file accordingly to deploy MKE on the cluster.

To apply configuration to a set of pre-existing machines, modify the `hosts` 
section of the file:

```yaml
hosts:
- ssh:
    address: 18.224.23.158
    keyPath: "/absolute/path/to/private/key.pem"
    port: 22
    user: root
  role: controller+worker
- ssh:
    address: 18.224.23.158
    keyPath: "/absolute/path/to/private/key.pem"
    port: 22
    user: ubuntu
  role: worker
- ssh:
    address: 18.117.87.45
    keyPath: "/absolute/path/to/private/key.pem"
    port: 22
    user: ubuntu
  role: worker
```

## Choose addons

A core part of MKE 4 is the ability to selectively install addons from a set of
curated and tested addons. Run `mkectl init` command to enable a set of default
addons that are considered core to MKE 4. You can modify the generated config to
enable or disable additional addons, as well as modify their settings.
The `init` command also includes a `--blueprint` option, which can be used to
print the generated blueprint that reflects the current MKE 4 configuration.

## Blueprints

All MKE 4 configuration files are translated into blueprints. 
A blueprint is a special type of file that is used
to create a Kubernetes Custom Resource (CRD) also called a blueprint. 
Thus, the blueprint file must be a valid Kubernetes YAML and contain many 
of the same fields as standard Kubernetes Objects.
MKE 4 uses the Blueprint Operator to manage all blueprints and their assignments.

A blueprint is composed of three sections:

1. The Kubernetes Provider details with settings for that provider.
This section is mostly managed by `mkectl` independently of the user provided MKE configuration file.
2. The infrastructure details that are used for the Kubernetes Cluster.
This is the `hosts` section of the MKE configuration file.
3. The components section, composed of various addons specified in the MKE
configuration file. The `mkectl` command transforms the MKE configuration options 
into specific settings in either Helm or Manifest type addons that are deployed
into the cluster.

To see detailed blueprint of an MKE config run `mkectl init --blueprint` command.
You can modify the blueprint directly, but any such modification is considered 
advanced and is not supported by MKE.

<!-- Please see the Blueprint Operator [documentation](https://mirantiscontainers.github.io/boundless/) for more details on blueprints. - broken link -->
