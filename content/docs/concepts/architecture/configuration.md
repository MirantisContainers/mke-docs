# Configuration and blueprints

The Mirantis Kubernetes Engine (MKE) 4 configuration file contains an
opinionated configuration on how to set up the MKE cluster.

With the MKE configuration file, you can:

- Define the number of nodes in the cluster.
- Define ways to access the nodes.
- Enable or disable certain MKE components.
- Configure MKE component features

Once set, the MKE configuration file is translated into a more complex
blueprint that contains the granular details on how to set up the cluster.

## Create configuration

1. Generate the default MKE configuration file by running:

    ```commandline
    mkectl init > mke.yaml
    ```

2. Modify the `hosts` section of the MKE configuration file, to apply the
   configuration to a set of pre-existing machines that you have set up in
   advance:

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

A core component of MKE 4 is a default set of curated and tested addons that you
can install by running `mkectl init` and subsequently applying the generated
configuration file.

Using the MKE configuration file, you can enable and disable the MKE 4 addons,
as well as modify their settings. In addition, you can use the
`mkectl init` command with the `--blueprint` option to print the generated
blueprint that reflects your current MKE 4 configuration.

## Blueprints

All MKE 4 configuration files are translated into blueprints,
a file type that is used to create Kubernetes Custom Resources (CRDs)
that are also called blueprints. MKE 4 uses Blueprint Operator to manage blueprints and their assignments.

Blueprint files must be in Kubernetes YAML format,
and they must contain many of the same fields as a standard Kubernetes Object.

A blueprint comprises three sections:

<dl>
  <dt><strong>Kubernetes Provider</strong></dt>
  <dd>Details the settings for the provider. For the most part, the Kubernetes Provider section is is managed by <code>mkectl</code>, independently of the user's MKE configuration file. </dd>
  <dt><strong>Infrastructure</strong></dt>
  <dd>Provides details that are used for the Kubernetes cluster; the <code>hosts</code> section of the MKE configuration file.</dd>
  <dt><strong>Components</strong></dt>
  <dd>Composed of addons that are specified in the MKE configuration file. The <code>mkectl</code> command transforms the configuration options
into specific settings for either Helm or Manifest type addons that are deployed into the cluster.</dd>
</dl>

To view a detailed blueprint of an MKE configuration, run the `mkectl init --blueprint` command.

> It is possible to directly modify a blueprint, however, such modifications are
> considered advanced and support by MKE 4 is not assured.

<!-- Please see the Blueprint Operator [documentation](https://mirantiscontainers.github.io/boundless/) for more details on blueprints. - broken link -->

<!-- Discuss with SME NNeisen moving "Create configuration" to "Getting Started" -->

<!-- Discuss reduction of Blueprint section here, instead sending readers to blueprint documentation at https://mirantiscontainers.github.io/blueprint/ -->

