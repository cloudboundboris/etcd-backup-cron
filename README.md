# etcd-backup-cron
ETCD backup script with logging 

This is my quick deployment POC k8s etcd backup script. This script will backup ETC and all pertinent files to an s3 compatible mount (in this case wasabi). This script assumes s3fs mount point is present (/mnt/wasabi) as an example.

fstab entry:
```bash
s3fs#<bucket name> /mnt/wasabi fuse _netdev,passwd_file=/root/.passwd-s3fs,url=https://s3.us-west-1.wasabisys.com,use_path_request_style,nonempty,allow_other 0 0
```
password is a key:value pair geenrated inside your s3 storage provider. 
