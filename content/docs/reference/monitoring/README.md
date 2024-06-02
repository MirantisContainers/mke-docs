# Monitoring

Mirantis Kubernetes Engine 4 (MKE4) uses the [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) a collection of Kubernetes manifests, [Grafana](https://grafana.com/) dashboards, and [Prometheus rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) combined with documentation and scripts to provide easy to operate end-to-end Kubernetes cluster monitoring with [Prometheus](https://prometheus.io/) using the [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator).

## Configuration

Grafana is enabled by default and may be toggled via the MKE4 config:
```
monitoring:
  enableGrafana: true
```

## Accessing the UIs

Prometheus and Grafana dashboards can be accessed quickly using kubectl port-forward after running the quickstart via the commands below.

### Prometheus

`$ kubectl --namespace mke port-forward svc/prometheus-operated 9090`

Then access via http://localhost:9090

### Grafana

`$ kubectl --namespace mke port-forward svc/monitoring-grafana 3000:80`

Then access via http://localhost:3000

## Opscare (Feature in progress)

[Mirantis Opscare](https://www.mirantis.com/resources/opscare-datasheet/) is disabled by default and may be enabled via the MKE4 config.

```
monitoring:
  enableOpscare: true
```

Enabling opscare installs the Prometheus [Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/) addon. In future releases, Opscare will additionally install a salesforce-notifier component as it does in MKE3.


