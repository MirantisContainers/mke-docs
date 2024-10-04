---
title: Kubelet Custom Profiles
weight: 2
---

Kubelet may be configured on a per-node basis using custom profiles. A Kubelet custom profile consists of a profile name and a set of values. The profile name is used to identify the profile and to target it to specific nodes in the cluster. The values are merged into the final Kubelet configuration applied to targeted node.

## Creating a custom profile

Custom profiles may be specified in the `kubelet.customProfiles` section of the MKE config. Every profile must have a unique name. Values may refer to fields in the Kubelet configuration file. For all possible values, see: [kubelet-config-file](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/).

Example: this configuration creates a custom profile named `hardworker` that specifies thresholds for garbage collection of images and eviction.

```yaml
spec:
  kubelet:
    customProfiles:
      - name: hardworker
        values:
          imageGCHighThresholdPercent: 85
          imageGCLowThresholdPercent: 80
          evictionHard:
            imagefs.available: 15%
            memory.available: 100Mi
            nodefs.available: 10%
            nodefs.inodesFree: 5%
```

## Applying a custom profile to a node

Hosts may be assigned a custom profile using the `Hosts` section of the MKE config. The profile name is an install-time argument for the host.

Example: this configuration applies the `hardworker` custom profile to the `localhost` node.

```yaml
  hosts:
  - role: single
    ssh:
      address: localhost
      keyPath: ~/.ssh/id_rsa
      port: 22
      user: root
      installFlags:
        - --profile=hardworker
```

## Precedence of Kubelet configuration

The Kubelet configuration of each node is created by merging a number of different configuration sources. For MKE, the order is as follows:

- Structured configuration values specified in the `kubelet` section of the MKE config (lowest precedence)
- Custom profile values specified in `kublelet.customProfiles`
- Runtime flags specified in `kubelet.extraArgs` (highest precedence)

For a more information about the precedence of Kubelet configuration values, see [kubelet-configuration-merging-order](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/#kubelet-configuration-merging-order).
