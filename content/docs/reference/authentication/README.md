# Authentication

## Pre-requisites

- IdP - If you are setting up OIDC or SAML then you will need an IdP with an application configured. This example setup uses [okta](https://www.okta.com/)

## Configuration

Authentication can be configured in the `authentication` section of the MKE4 config. By default, authentication is enabled but each of the individual authentication methods are disabled. It can be disabled by setting the root `enabled`to `false`. This will completely remove any authentication related components from being installed on the cluster.

```yaml
authentication:
  enabled: true
```

## Example Client App

We do not currently have a client for Dex. We can still test the authentication process by using the example-app from the dex repository. The example-app is a simple web application that sends requests to the Dex login page.

There is a deployment file that can be used to deploy the example app on the created cluster.

```bash
kubectl apply -f ./deployments/dex/dex-example-app.yaml
```

If you are running the cluster in a VM on your local machine, you can use the following commands to port forward the example-app and dex services to your local machine:

```bash
kubectl -n mke port-forward deployment/dex-example-app 5555:5555
kubectl -n mke port-forward deployment/dex 5556:5556
```

The example-app will be available at `http://localhost:5555/login`. You can now navigate to this URL in a browser and test the authentication flow.

Deploying the example app and forwarding the ports can be done with a single command from our Makefile:

```bash
make dex-app
```

> **Note** This will fail if it is ran too soon and the applications are not ready. Rerunning it will work once the applications are ready.

## Authentication Methods

From here, check out the individual files for the different authentication methods:

- [OIDC](./OIDC.md)
- [SAML](./SAML.md)
- [LDAP](./LDAP.md)
