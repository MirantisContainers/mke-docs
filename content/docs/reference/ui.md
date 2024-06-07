# Dashboard add-on for MKE
The MKE Dashboard add-on provides a UI for kubernetes resource management. 

Future: User management and administrative configurations will also be possible through the dashboard.

[INSERT SCREENSHOT]

## Installation

To install the Dashboard add-on do this
```
[TBD]

```

## 4.0.0-alpha.2.0 release

### What is included
- Metrics eg. node performance + usage statistics
- Basic kubernetes management of the following (View, Create, Update + Delete)
 - Configurations: ConfigMaps
 - Controllers: ReplicaSets, ReplicationControllers, StatefulSets, Jobs, CronJobs, Daemonsets + Deployments
 - Namespaces
 - Nodes
 - Pods
 - Services
 - ServiceAccounts
 - Storage: StorageClasses, PersistantVolumes + PersistantVolumeClaims
- View kubernetes resources by namespace, or all namespaces at once

### Future
- User management 
- User settings
- Admin settings: authentication, ingress, backups, certificates, telemetry + logging.
- Support bundle access
- App notifications + alerts
- Improved detail view of individual kubernetes resources
- Statuses for kubernetes objects
- ...and more
