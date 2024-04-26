# Ingress Controller

NGINX Ingress Controller for Kubernetes manages traffic that originates outside your cluster (ingress traffic) using the [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) rules.



## Configuration

Ingress Controller can be configured using the `ingressController` section of the MKE4 config. 
By default, Nginx Ingress Controller is disabled. It can be enabled by setting `enabled`to `true`.
```yaml
ingressController:
  enabled: true
```


The other optional parameters that can be used to configure the Nginx Ingress Controller are mentioned below.

| Field                           | Description                                                                                                                                                                                                                                                                                   |
|---------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| replicaCount                    | Sets the number of NGINX Ingress Controller deployment replicas. <br/> Default: 2                                                                                                                                                                                                             |
| enableLoadBalancer              | Enables an external load balancer. <br/>Valid values: true, false.<br/> Default: false                                                                                                                                                                                                        |
| extraArgs                       | Additional command line arguments to pass to Ingress-Nginx Controller.                                                                                                                                                                                                                        |                                                                                                                                                                                                                    |
| extraArgs.httpPort              | Sets the container port for servicing HTTP traffic. Default: 80                                                                                                                                                                                                                               |
| extraArgs.httpsPort             | Sets the container port for servicing HTTPS traffic. Default: 443                                                                                                                                                                                                                             |
| extraArgs.enableSslPassthrough  | Enables SSL passthrough. Default: false                                                                                                                                                                                                                                                       |
| extraArgs.defaultSslCertificate | Sets the Secret that contains an SSL certificate to be used as a default TLS certificate. <br/> Valid value: `<namespace>`/`<name>`                                                                                                                                                           |
| preserveClientIP                | Enables preserving inbound traffic source IP. <br/>Valid values: true, false. <br/> Default: false                                                                                                                                                                                            |
| externalIPs                     | Sets the list of external IPs for Ingress service.<br/>Default: [] (empty)                                                                                                                                                                                                                    |
| affinity                        | Sets node affinity. <br/> Default: {} (empty) <br/>  <br/> [Example Usage](#affinity) <br/> <br/> Reference: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity.                                                                                   |
| tolerations                     | Sets node toleration. <br/> Default: [] (empty) <br/> <br/> [Example Usage](#tolerations)<br/> <br/> Please refer to https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ for more details.                                                                                     |          |
| configMap                       | Adds custom configuration options to Nginx. <br/> Default: {} (empty)  <br/><br/>  For the complete list of available options, refer to the [NGINX Ingress Controller ConfigMap](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#configuration-options). |
| tcpServices                     | Sets TCP service key-value pairs; enables TCP services. <br/> Default: {} (empty) <br/> <br/> [Example Usage](./tcp_udp_services.md)  <br/> <br/>  Please refer to  https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md for more info.         |
| udpServices                     | Sets UDP service key-value pairs; enables UDP services. <br/> Default: {} (empty) <br/> <br/> [Example Usage](./tcp_udp_services.md)  <br/> <br/>  Please refer to  https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md for more info.         |
| nodePorts                       | Sets node ports for the external HTTP/HTTPS/TCP/UDP listener. <br/> Default: HTTP: 33000, HTTPS: 33001                                                                                                                                                                                        |
| ports                           | Sets port for the internal HTTP/HTTPS listener.  <br/> Default: HTTP: 80, HTTPS: 443                                                                                                                                                                                                          |
| disableHttp                     | Disables the HTTP listener. <br/> Default: false                                                                                                                                                                                                                                              |



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

