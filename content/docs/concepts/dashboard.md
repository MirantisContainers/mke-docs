---
title: MKE Dashboard
weight: 5
---

{{< callout type="info" >}} Available since 4.0.0-alpha.2.0 {{< /callout >}}

The MKE Dashboard add-on provides the web UI to manage Kubernetes resources management:

![MKE dasboard preview](ui-preview.png)

The MKE Dashboard is enabled by default in the MKE installation.
To access the MKE Dashboard, visit the address of the load balancer endpoint
on a freshly-installed cluster. For details, refer to [Load balancer requirements](../../getting-started/system-requirements#load-balancer-requirements).

To disable the MKE Dashboard, set the `enabled` field to `false` in the `dashboard`
section of the `config.yaml` file:

```yaml
   dashboard:
     enabled: false
```
