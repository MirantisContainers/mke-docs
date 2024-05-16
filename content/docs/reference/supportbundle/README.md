# Support bundle

For the Alpha.1 release, MKE 4 deploys k0s v1.29.3, which does not inherently support Replicated's [support bundle tool](https://troubleshoot.sh/docs/support-bundle/introduction/).

To manually collect a support bundle, you can use the following steps:

- SSH into the manager node.
- Download and install the `support-bundle` tool:
  ```shell
  curl -L https://github.com/replicatedhq/troubleshoot/releases/latest/download/support-bundle_linux_amd64.tar.gz | tar xzvf -
  ```
- Create a YAML file that describes the support bundle configuration. For example, create a file named `support-bundle-worker.yaml` with the following content:
```yaml
  apiVersion: troubleshoot.sh/v1beta2
  kind: SupportBundle
  metadata:
    name: sample
  spec:
    collectors:
      - logs:
          selector:
            - app.kubernetes.io/name=boundless-operator-webhook
        namespace: boundless-system
        name: logs/boundless-system
      - logs:
          selector:
            - control-plane=controller-manager
          namespace: boundless-system
          name: logs/boundless-system
  ```
  This configuration collects the following information:
  - Cluster information
  - Cluster resources
  - Logs from the `boundless-operator-controller-manager` and `boundless-operator-webhook` pods will be stored in the `logs/` directory of the output.
  
Another option is to collect host information by utilizing the YAML file provided by k0s in https://docs.k0sproject.io/stable/support-bundle-worker.yaml

- Run the `support-bundle` tool:
    ```shell
    ./support-bundle --kubeconfig /var/lib/k0s/pki/admin.conf <support-bundle-worker.yaml>
    ```
    NOTE: 
    - The `support-bundle` tool requires the `kubeconfig` file to be passed as an argument. The `kubeconfig` file is located at `/var/lib/k0s/pki/admin.conf`.
    - The support bundle will be saved to a file named `support-bundle-<timestamp>.tar.gz`.