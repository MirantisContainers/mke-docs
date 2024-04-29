# Ingress Controller

The default ingress controller offered by MKE-4 is NGINX Ingress Controller.  It manages traffic that originates outside your cluster (ingress traffic) using the [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) rules. 
This is the only supported Ingress controller. No additional controllers are supported.


## Configuration

Ingress Controller can be configured using the `ingressController` section of the MKE4 config. 
By default, Nginx Ingress Controller is disabled. It can be enabled by setting `enabled` to `true`.
```yaml
ingressController:
  enabled: true
```


The other optional parameters that can be used to configure the Nginx Ingress Controller are mentioned below.

| Field                           | Description                                                                                                                                                                                                                                                         | Default                   |
|---------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|
| replicaCount                    | Sets the number of NGINX Ingress Controller deployment replicas.                                                                                                                                                                                                    | 2                         |
| enableLoadBalancer              | Enables an external load balancer. <br/>Valid values: true, false.                                                                                                                                                                                                  | false                     |
| extraArgs                       | Additional command line arguments to pass to Ingress-Nginx Controller.                                                                                                                                                                                              | {} (empty)                |                                                                                                                                                                                                                    |
| extraArgs.httpPort              | Sets the container port for servicing HTTP traffic.                                                                                                                                                                                                                 | 80                        |
| extraArgs.httpsPort             | Sets the container port for servicing HTTPS traffic.                                                                                                                                                                                                                | 443                       |
| extraArgs.enableSslPassthrough  | Enables SSL passthrough.                                                                                                                                                                                                                                            | false                     |
| extraArgs.defaultSslCertificate | Sets the Secret that contains an SSL certificate to be used as a default TLS certificate. <br/> Valid value: `<namespace>`/`<name>`                                                                                                                                 | ""                        |
| preserveClientIP                | Enables preserving inbound traffic source IP. <br/>Valid values: true, false.                                                                                                                                                                                       | false                     |
| externalIPs                     | Sets the list of external IPs for Ingress service.                                                                                                                                                                                                                  | [] (empty)                |
| affinity                        | Sets node affinity.  <br/>  <br/> [Example Usage](#affinity) <br/> <br/> Reference: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity.                                                                                  | {} (empty)                |
| tolerations                     | Sets node toleration. <br/> <br/> [Example Usage](#tolerations)<br/> <br/> Please refer to https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ for more details.                                                                                     | [] (empty)                |          |
| configMap                       | Adds custom configuration options to Nginx.  <br/><br/>  For the complete list of available options, refer to the [NGINX Ingress Controller ConfigMap](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#configuration-options). | {} (empty)                |
| tcpServices                     | Sets TCP service key-value pairs; enables TCP services. <br/> <br/> [Example Usage](./tcp_udp_services.md)  <br/> <br/>  Please refer to  https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md for more info.         | {} (empty)                |
| udpServices                     | Sets UDP service key-value pairs; enables UDP services. <br/> <br/> [Example Usage](./tcp_udp_services.md)  <br/> <br/>  Please refer to  https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md for more info.         | {} (empty)                |
| nodePorts                       | Sets node ports for the external HTTP/HTTPS/TCP/UDP listener.                                                                                                                                                                                                       | HTTP: 33000, HTTPS: 33001 |
| ports                           | Sets port for the internal HTTP/HTTPS listener.                                                                                                                                                                                                                     | HTTP: 80, HTTPS: 443      |
| disableHttp                     | Disables the HTTP listener.                                                                                                                                                                                                                                         | false                     |



### Affinity
You can specify node affinities using the `ingressController.affinity.nodeAffinity` field in your config file.

An example that uses `requiredDuringSchedulingIgnoredDuringExecution` to schedule the ingress controller pods.
```yaml
ingressController:
  enabled: true
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: kubernetes.io/hostname
                operator: In
                values:
                  - ip-172-31-42-30
```


### Tolerations

The user can set Node tolerations for server scheduling to nodes with taints using the `ingressController.tolerations` field in your config file.

An example that uses a toleration with `NoExecute` effect.
```yaml
ingressController:
  enabled: true
  tolerations:
  - key: "key1"
    operator: "Equal"
    value: "value1"
    effect: "NoExecute"
```

## Example configuration

An example configuration for Ingress Controller is shown below.

```yaml
ingressController:
  enabled: true
  enableLoadBalancer: false
  numReplicas: 1
  preserveClientIP: true
  tolerations:
    - key: "key1"
      operator: "Equal"
      value: "value1"
      effect: "NoExecute"
  extraArgs:
    httpPort: 0
    httpsPort: 0
    enableSslPassthrough: true
    defaultSslCertificate: ""
  configMap:
    access-log-path: "/var/log/nginx/access.log"
    generate-request-id: "true"
    use-forwarded-headers: "true"
    error-log-path: "/var/log/nginx/error.log"
  tcpServices:
    9000: "default/tcp-echo:9000"
  udpServices:
    5005: "default/udp-listener:5005"
  nodePorts:
    http: 33003
    https: 33004
    tcp:
      9000: 33011
    udp:
      5005: 33012
   ports:
    http: 8080
    https: 4443
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: kubernetes.io/hostname
                operator: In
                values:
                  - ip-172-31-42-30
```


## MKE-3 vs MKE-4 Ingress config parameters

| MKE-3                                                                                                                                                                        | MKE-4                                                                                                                                                                                                                                                                                                                                                                                                                |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [cluster_config.ingress_controller.enabled]                                                                                                                                  | ingressController.enabled                                                                                                                                                                                                                                                                                                                                                                                            |
 | [cluster_config.ingress_controller.ingress_num_replicas]                                                                                                                     | ingressController.numReplicas                                                                                                                                                                                                                                                                                                                                                                                        |
 | [cluster_config.ingress_controller.ingress_enable_lb]                                                                                                                        | ingressController.enableLoadBalancer                                                                                                                                                                                                                                                                                                                                                                                 |
 | [cluster_config.ingress_controller.ingress_preserve_client_ip]                                                                                                               | ingressController.preserveClientIP                                                                                                                                                                                                                                                                                                                                                                                   |
| [[cluster_config.ingress_controller.ingress_node_toleration]] <br/> key = "com.docker.ucp.manager" <br/> value = "" <br/> operator = "Exists" <br/>effect = "NoSchedule"     | ingressController.tolerations </br> - key: "key1" </br> operator: "Equal" </br> value: "value1" </br> effect: "NoExecute"                                                                                                                                                                                                                                                                                            |
 | [cluster_config.ingress_controller.ingress_config_map]                                                                                                                       | ingressController.configMap                                                                                                                                                                                                                                                                                                                                                                                          |
 | [cluster_config.ingress_controller.ingress_tcp_services] <br/> 9000 = "default/tcp-echo:9000"                                                                                | ingressController.tcpServices:<br/>9000: "default/tcp-echo:9000"                                                                                                                                                                                                                                                                                                                                                     |
 | [cluster_config.ingress_controller.ingress_udp_services] <br/> 5005 = "default/udp-listener:5005"                                                                            | ingressController.udpServices:<br/> 5005: "default/udp-listener:5005"                                                                                                                                                                                                                                                                                                                                                |
 | [cluster_config.ingress_controller.ingress_extra_args] <br/> http_port = 8080 <br/> https_port = 4443 <br/> enable_ssl_passthrough = true <br/> default_ssl_certificate = "" | ingressController.extraArgs: <br/> httpPort: 0 <br/> httpsPort: 0 <br/> enableSslPassthrough: true <br/> defaultSslCertificate: ""                                                                                                                                                                                                                                                                                   |
 | [cluster_config.ingress_controller.ingress_node_affinity]                                                                                                                    | ingressController.affinity                                                                                                                                                                                                                                                                                                                                                                                           |                                                                                                        |                                                                                                                                    |
 | [[cluster_config.ingress_controller.ingress_exposed_ports]] <br/> name = "http2" <br/> port = 80 <br/> target_port = 8080 <br/> node_port = 33001 <br/> protocol = ""        | Deprecated in MKE 4.<br/>  <br/> The http and https ports are enabled by default on 80, 443 respectively.  If the user wants to change it, they can use ingressController.ports<br/> NodePorts for http and https can be configured via ingressController.nodePorts. The default values are 33000 and 33001 respectively. <br/> For configuring TCP/UDP ports, please refer to this [guide](./tcp_udp_services.md) . |