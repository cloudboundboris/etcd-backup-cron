# etcd-backup-cron
ETCD backup script with logging 

This is my quick deployment POC k8s etcd backup script. This script will backup ETC and all pertinent files to an s3 compatible mount (in this case wasabi). This script assumes s3fs mount point is present (/mnt/wasabi) as an example.

fstab entry:
```bash
s3fs#<bucket name> /mnt/wasabi fuse _netdev,passwd_file=/root/.passwd-s3fs,url=https://s3.us-west-1.wasabisys.com,use_path_request_style,nonempty,allow_other 0 0
```
password is a key:value pair geenrated inside your s3 storage provider. 

## Wasabi Entrypoints:

### Americas

|**Region**|**Service URL**|**Alias/Alternative URL**|
|---|---|---|
|Wasabi US East 1 (N. Virginia)|s3.wasabisys.com|s3.us-east-1.wasabisys.com|
|Wasabi US East 2 (N. Virginia)|s3.us-east-2.wasabisys.com||
|Wasabi US Central 1 (Texas)|s3.us-central-1.wasabisys.com||
|Wasabi US West 1 (Oregon)|s3.us-west-1.wasabisys.com||
|Wasabi CA Central 1 (Toronto)|s3.ca-central-1.wasabisys.com||

### EMEA

| Wasabi EU Central 1 (Amsterdam)   | s3.eu-central-1.wasabisys.com | s3.nl-1.wasabisys.com |
| --------------------------------- | ----------------------------- | --------------------- |
| Wasabi EU Central 2 (Frankfurt)   | s3.eu-central-2.wasabisys.com | s3.de-1.wasabisys.com |
| Wasabi EU West 1 (United Kingdom) | s3.eu-west-1.wasabisys.com    | s3.uk-1.wasabisys.com |
| Wasabi EU West 2 (Paris)          | s3.eu-west-2.wasabisys.com    | s3.fr-1.wasabisys.com |
| Wasabi EU West 3 (United Kingdom) | s3.eu-west-3.wasabisys.com    | s3.uk-2.wasabisys.com |
| Wasabi EU South 1 (Milan)         | s3.eu-south-1.wasabisys.com   | s3.it-1.wasabisys.com |
