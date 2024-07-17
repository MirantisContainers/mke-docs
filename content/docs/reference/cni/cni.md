# CNI

>MKE 4 supports Calico OSS as the CNI

## Configuration

The `network` section of the MKE4 configuration file renders as follows:

```yaml
network:
  serviceCIDR: 10.96.0.0/16
  nodePortRange: 32768-35535
  kubeProxy:
    disabled: false
    mode: iptables
    metricsbindaddress: 0.0.0.0:10249
    iptables:
      masqueradebit: null
      masqueradeall: false
      localhostnodeports: null
      syncperiod:
        duration: 0s
      minsyncperiod:
        duration: 0s
    ipvs:
      syncperiod:
        duration: 0s
      minsyncperiod:
        duration: 0s
      scheduler: ""
      excludecidrs: []
      strictarp: false
      tcptimeout:
        duration: 0s
      tcpfintimeout:
        duration: 0s
      udptimeout:
        duration: 0s
    nodeportaddresses: []
  nllb:
    disabled: true
  cplb:
    disabled: true
  providers:
  - provider: calico
    enabled: true
    CALICO_DISABLE_FILE_LOGGING: true
    CALICO_STARTUP_LOGLEVEL: DEBUG
    FELIX_LOGSEVERITYSCREEN: DEBUG
    clusterCIDRIPv4: 192.168.0.0/16
    deployWithOperator: false
    enableWireguard: false
    ipAutodetectionMethod: null
    mode: vxlan
    overlay: Always
    vxlanPort: 4789
    vxlanVNI: 10000
  - provider: kuberouter
    enabled: false
    deployWithOperator: false
  - provider: custom
    enabled: false
    deployWithOperator: false
```

Refer to the following table for detail on all of the configurable `network` fields:

| Field                                                      | Description                                                                        | Valid values        |  Default     |
|------------------------------------------------------------|------------------------------------------------------------------------------------|---------------------|:------------:|
| serviceCIDR                                                | Sets the (ipv4) Kubernetes cluster IP Range for services.                          | a valid ipv4 CIDR   | 10.96.0.0/16 |
| nodePortRange                                              | Sets the allowed port range for Kubernetes services of NodePort type.              | a valid port range  | 32768-35535  |
| providers                                                  | Sets the provider for active CNI. Only Calico is supported currently               | NA                  | Calico       |


For Calico provider, the following fields of its provider setting are configurable:

| Field                                                      | Description                                                                        | Valid values        |  Default     |
|------------------------------------------------------------|------------------------------------------------------------------------------------|---------------------|:------------:|
| enabled                                                    | Name of the external storage provider. AWS is currently the only available option. | true                |    true      |
| clusterCIDRIPv4                                            | Sets Kubernetes cluster IP pool for the Pods to be allocated from.                 | a valid ipv4 CIDR   |192.168.0.0/16|
| ipAutodetectionMethod                                      | Sets autodetecting method for IPv4 address for the host.                           | provider specified  |    none      |
| mode                                                       | Sets ipv4 overlay networking mode                                                  | ipip, vxlan         |    vxlan     |
| vxlanPort                                                  | Sets the vxlan port for vxlan mode                                                 | valid port number   |    4789      |
| vxlanVNI                                                   | Sets the vxlan VNI for vxlan mode                                                  | valid VNI number    | 10000        |
| CALICO_STARTUP_LOGLEVEL                                    | Sets the early log level for calico/node                                           | provider specific   | DEBUG        |
| FELIX_LOGSEVERITYSCREEN                                    | Sets the log level for calico/felix                                                | provider specific   | DEBUG        |

Users should consult the provider documentation for exact valid values for configurable fields for which Valid values above are marked as "provider specific"

## Existing Limitations

- Components using nodeports may have their own specific way to specify the ports numbers for Nodeports
  and they may need to be changed at the same time as the nodePortRange
