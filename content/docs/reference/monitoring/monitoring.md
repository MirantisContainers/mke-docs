# Monitoring

This document provides guidance on setting up monitoring for your
Kubernetes clusters using Mirantis Kubernetes Engine (MKE) 4. 
The monitoring setup is based on the [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack),
offering a comprehensive solution for collecting, storing, and visualizing metrics.

## Monitoring tools

Descriptions for each of the monitoring tools that MKE 4 uses are
available in the table below.

| Monitoring tool    | Default State | Configuration Key          | Description                                                                    |
|------------|---------------|----------------------------|--------------------------------------------------------------------------------|
| Grafana    | enabled       | `monitoring.enableGrafana` | Provides a web interface for viewing metrics and logs collected by Prometheus  |
| Prometheus | enabled       | -                          | Collects and stores metrics                                                    |
| Opscare    | disabled      | `monitoring.enableOpscare` | (Future feature) Includes additional monitoring capabilities like Alertmanager |

### Grafana

[Grafana](https://grafana.com/) is an open-source platform for monitoring.
It provides a rich set of tools for visualizing time-series data,
including a variety of graph types and dashboards.

Grafana is enabled in MKE 4 by default and may be disabled through the configuration:

```yaml
monitoring:
  enableGrafana: true
```

To access Grafana dashboard:

1. Run the following command to `port-forward` Grafana:

    ```bash
    kubectl --namespace mke port-forward svc/monitoring-grafana 3000:80
    ```

2. Access Grafana dashboard through [http://localhost:3000](http://localhost:3000).

### Prometheus

[Prometheus](https://prometheus.io/) is an open-source monitoring and alerting
toolkit designed for reliability and scalability. It collects and stores metrics
as time series data, providing powerful query capabilities and a flexible alerting system.

To access Prometheus dashboard:

1. Run the following command to `port-forward` Prometheus:

    ```bash
    kubectl --namespace mke port-forward svc/prometheus-operated 9090
    ```

2. Access Prometheus dashboard through [http://localhost:9090](http://localhost:9090).

## Opscare (Feature in progress)

[Mirantis Opscare](https://www.mirantis.com/resources/opscare-datasheet/) is
an advanced monitoring and alerting solution. It enhances the monitoring
capabilities of MKE 4 by integrating additional tools and features, such as
[Prometheus Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/).
Future releases will include more integrations, such as a Salesforce-notifier component.

Mirantis OpsCare is disabled by default and may be enabled through the MKE4 configuration.

```yaml
monitoring:
  enableOpscare: true
```
