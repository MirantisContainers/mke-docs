---
title: Backup and restore
weight: 1
---

MKE 4 supports backups and restores of cluster data through the use of the
[Velero](https://velero.io/) addon. Backups are enabled by default.

## Backup configuration

The `backup` section of the MKE 4 configuration file renders as follows:

```yaml
backup:
  enabled: true
  storage_provider:
    type: InCluster
    in_cluster_options:
      exposed: true
      distributed: false
```

By default, MKE 4 supports backups that use the in-cluster storage
provider, as shown in the `type.InCluster` field.
MKE 4 in-cluster backups are implemented using the
[MinIO addon](https://microk8s.io/docs/addon-minio).

The `exposed.true` setting indicates that the MinIO service is
exposed through `NodePort`, which Velero requires to function correctly. Core
backup functionality works, even if the service is not exposed.

The `distributed` setting configures MinIO storage to run in distributed mode.

Refer to the following list to detail on all the configuration file
`backup` fields:

<!-- [TODO turn this list into a table once column widths are fixed] -->

`enabled` 
: Indicates whether backup/restore functionality is enabled.

  - Valid values: `true`, `false`
  - Default: `true`

`storage_provider.type `

: Indicates whether the storage type in use is in-cluster or external.

  -  `InCluster`, `External`
  - Default: `InCluster`

`storage_provider.in_cluster_options.exposed`

: Indicates whether to expose InCluster (MinIO) storage through NodePort.

  - Valid values: `true`, `false`
  - Default: `true`

`storage_provider.in_cluster_options.distributed`

: Indicates whether to run MinIO in distributed mode.

  - Valid values: `true`, `false`
  - Default: `false`

`storage_provider.external_options.provider`

: Name of the external storage provider. AWS is currently the only available option.

  - Valid values: `aws`
  - Default: `aws`

`storage_provider.external_options.bucket`

: Name of the pre-created bucket to use for backup storage.

`storage_provider.external_options.region `

: Region in which the bucket exists.

`storage_provider.external_options.credentials_file_path`

: Path to the Credentials file.

`storage_provider.external_options.credentials_file_profile`

: Profile in the Credentials file to use

## Create a backup and perform a restore

For information on how to create backups and perform restores for both storage
provider types, refer to:

- [In-cluster storage provider](in-cluster)
- [External storage provider](external)

## Existing limitations

- Scheduled backups are not implemented.

- Restoring a backup to a new set of nodes is not supported for the in-cluster 
  storage provider. Backups must currently be restored in the same cluster in
  which the backup was taken.
