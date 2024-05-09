# Backup & Restore

MKE4 supports backup and restoring of the cluster data using the [Velero](https://velero.io/) addon. Backup is enabled by default.

## Configuration

The default `backup` section of the MKE4 config is as follows:

```yaml
backup:
  enabled: true
  storage_provider:
    type: InCluster
    in_cluster_options:
      exposed: true
      distributed: false

```

With the default setup, MKE is set up to support backups using the in-cluster storage provider. This is implemented via the MinIO addon that supports in-cluster object storage.
The `exposed` option is set to `true` which means that the MinIO service is exposed via NodePort. This is needed for all Velero operations to work correctly (i.e logs, describing backups). However the core backup functionality should work even if the service is not exposed.
The `distributed` option configures whether to run the MinIO storage in distributed mode.

See [in_cluster.md](./in_cluster.md) for instructions on how to create backups and restores using the in-cluster storage provider.
See [external.md](./external.md) for instructions on how to create backups and restores using an external storage provider. (currently just AWS)

## Existing Limitations

Scheduled backups are a feature in MKE3 that is planned to be supported before MKE4 GA but not yet implemented.
Additionally, restoring a backup to a new set of nodes is not yet supported for in cluster storage provider. The backup must currently be restored in the same cluster it was taken in.

## All fields


| Field                                                      | Description                                                                                     | Default
|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| enabled                                                    | Enables backup/restore functionality. <br/>Valid values: true, false.                           | true
| storage_provider.type                                      | What Storage Provider Type to use. <br/>Valid values: 'InCluster', 'External'.                  | InCluster
| storage_provider.in_cluster_options.exposed                | Whether to expose InCluster (MinIO) storage via NodePort. <br/>Valid values: true, false.       | true
| storage_provider.in_cluster_options.distributed            | Whether to run MinIO in distributed mode. <br/>Valid values: true, false.                       | false
| storage_provider.external_options.provider                 | What External Provider to use. <br/>Valid values: Currently just 'aws'.                         | ""
| storage_provider.external_options.bucket                   | Name of the pre-created bucket to use for backup storage.                                       | ""
| storage_provider.external_options.region                   | Region where the bucket exists.                                                                 | ""
| storage_provider.external_options.credentials_file_path    | Path to Credentials File.                                                                       | ""
| storage_provider.external_options.credentials_file_profile | Profile in the Credentials file to use.                                                         | ""