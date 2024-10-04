---
title: Kubernetes Components
weight: 2
---

Mirantis Kubernetes Engine (MKE) 4 uses K0s to deploy core Kubernetes components. Those components may be configured through the MKE config file.

## kubelet

The kubelet is the primary "node agent" that runs on each node.

It may be configured for all nodes using the `kubelet` section of the MKE config.

```yaml
spec:
  kubelet:
    eventRecordQPS: 50
    maxPods: 110
    podPidsLimit: -1
    podsPerCore: 0
    protectKernelDefaults: false
    seccompDefault: false
    workerKubeReserved:
      cpu: 50m
      ephemeral-storage: 500Mi
      memory: 300Mi
    managerKubeReserved:
      cpu: 250m
      ephemeral-storage: 4Gi
      memory: 2Gi
```

Advanced: the kubelet may be further configured using the `extraArgs` field. This map creates runtime flags that are passed directly to the kubelet process. Flags configured in this way are applied with the highest precedence.

```yaml
spec:
  kubelet:
    extraArgs:
      event-burst: 50
```

Advanced: the kubelet may also be configured with custom profiles. These profiles offer greater control of the `KubeletConfiguration` and may be targeted to specific hosts.

## kube-apiserver

The Kubernetes API server validates and configures data for the api objects which include pods, services, replicationcontrollers, and others. The API Server services REST operations and provides the frontend to the cluster's shared state through which all other components interact.

It may be configured for all controllers using the `apiServer` section of the MKE config.

```yaml
spec:
  apiServer:
    audit:
      enabled: false
      logPath: /var/lib/k0s/audit.log
      maxAge: 30
      maxBackup: 10
      maxSize: 10
    encryptionProvider: /var/lib/k0s/encryption.cfg
    eventRateLimit:
      enabled: false
    requestTimeout: 1m0s
```

Advanced: the API server may be further configured using the `extraArgs` field. This map creates runtime flags that are passed directly to the kube-apiserver process.

## kube-controller-manager

The Kubernetes controller manager is a daemon that embeds the core control loops shipped with Kubernetes. In applications of robotics and automation, a control loop is a non-terminating loop that regulates the state of the system. In Kubernetes, a controller is a control loop that watches the shared state of the cluster through the apiserver and makes changes attempting to move the current state towards the desired state. Examples of controllers that ship with Kubernetes today are the replication controller, endpoints controller, namespace controller, and serviceaccounts controller.

It may be configured for all controllers using the `controllerManager` section of the MKE config.

```yaml
spec:
  controllerManager:
    terminatedPodGCThreshold: 12500
```

Advanced: the controller manager may be further configured using the `extraArgs` field. This map creates runtime flags that are passed directly to the kube-controller-manager process.

## kube-scheduler

The Kubernetes scheduler is a control plane process which assigns Pods to Nodes. The scheduler determines which Nodes are valid placements for each Pod in the scheduling queue according to constraints and available resources. The scheduler then ranks each valid Node and binds the Pod to a suitable Node. Multiple different schedulers may be used within a cluster; kube-scheduler is the reference implementation. 

It may be configured for all controllers using the `scheduler` section of the MKE config.

```yaml
spec:
  scheduler:
```

Advanced: the scheduler may be further configured using the `extraArgs` field. This map creates runtime flags that are passed directly to the kube-scheduler process.
