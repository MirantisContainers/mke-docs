---
title: Telemetry
weight: 4
---

You can set MKE to automatically record and transmit data to Mirantis through
an encrypted channel for monitoring and analysis purposes. This data helps the
Mirantis Customer Success Organization to better understand how customers
use MKE. It also provides product usage statistics, which is key feedback that
helps product teams in their efforts to enhance Mirantis products and
services.

## Enable telemetry through the MKE CLI

To enable telemetry for MKE 4, set the `tracking.enabled` section of the MKE configuration file.

```yaml
tracking:
  enabled: true
```


`mke-operator` will take a few moments to reconcile the change in the
configuration, after which MKE will thereafter transmit key usage data to
Mirantis by way of a secure Segment endpoint.

## Enable telemetry through the MKE web UI

1. Log in to the MKE web UI as an administrator.

2. Click **Admin Settings** to display the available options.

3. Click **Telementry** to call the **Telemetry** screen.

4. Click **Enable Telemetry**.

5. Click **Save**.
