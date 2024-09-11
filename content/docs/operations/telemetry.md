---
title: Telemetry
weight: 4
---

You can set MKE to automatically record and transmit data to Mirantis through
an encrypted channel for monitoring and analysis purposes. This data helps the
Mirantis Customer Success Organization to better understand how our customers
use MKE. It also provides product usage statistics, which is key feedback that
helps our product teams in their efforts to enhance Mirantis products and
services.

## Enable telemetry through the MKE CLI ##

In the `mkeconfig` object in the `mke` namespace, set `tracking.enabled` to `true`.

```bash
kubectl edit mkeconfig -n mke
```

Following this, `mke-opeartor` reconciles the change in the configuration. Once
this is complete, MKE will thereafter transmit key usage data to Mirantis by
way of a a secure Segment endpoint.

## Enable telemetry through the MKE web UI

