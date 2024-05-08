# Backup and Restore Using In Cluster Storage Provider
By default, MKE will store backups and restores using the in cluster storage provider (MinIO). The below instructions assume you have created a cluster and applied a blueprint with the default MKE backup configuration.

## Usage
Backups can be created using `mkectl backup create --name <name>`.

```shell
mkectl backup create --name test
INFO[0000] Creating backup test...
Backup request "test" submitted successfully.
Run `velero backup describe test` or `velero backup logs test` for more details.
INFO[0000] Waiting for backup test to complete...
INFO[0003] Waiting for backup to complete. Current phase: InProgress
INFO[0006] Waiting for backup to complete. Current phase: InProgress
INFO[0009] Waiting for backup to complete. Current phase: InProgress
INFO[0012] Waiting for backup to complete. Current phase: InProgress
INFO[0015] Waiting for backup to complete. Current phase: Completed
```

The backup should now be present in the MinIO bucket. You can list the backups using `mkectl backup list`.

```shell
mkectl backup list
NAME   STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
test   Completed   0        0          2024-05-07 17:29:18 -0400 EDT   29d       default            <none>
```

Optionally, detailed logs of a backup can be viewed via `mkectl backup logs --name test`

To create a restore off the backup we created we can run `mkectl restore create --name test`

```shell
mkectl restore create --name test
INFO[0000] Waiting for restore test-20240507173309 to complete...
INFO[0000] Waiting for restore to complete. Current phase: InProgress
INFO[0003] Waiting for restore to complete. Current phase: InProgress
INFO[0006] Waiting for restore to complete. Current phase: InProgress
INFO[0009] Waiting for restore to complete. Current phase: InProgress
INFO[0012] Waiting for restore to complete. Current phase: InProgress
INFO[0015] Waiting for restore to complete. Current phase: InProgress
INFO[0018] Waiting for restore to complete. Current phase: InProgress
INFO[0021] Waiting for restore to complete. Current phase: InProgress
INFO[0024] Waiting for restore to complete. Current phase: InProgress
INFO[0027] Waiting for restore to complete. Current phase: Completed
INFO[0027] Restore test-20240507173309 completed successfully
```

We can list the restores using `mkectl restore list`

```shell
mkectl restore list
NAME                  BACKUP   STATUS      STARTED                         COMPLETED                       ERRORS   WARNINGS   CREATED                         SELECTOR
test-20240507173309   test     Completed   2024-05-07 17:33:09 -0400 EDT   2024-05-07 17:33:34 -0400 EDT   0        121        2024-05-07 17:33:09 -0400 EDT   <none>
```

We can optionally view detailed logs similar to the backup logs using `mkectl restore logs --name test-20240507173309`.


