#!/bin/bash
set -euo pipefail

# Directories
BACKUP_DIR="/mnt/wasabi"
ETCD_BACKUP_DIR="${BACKUP_DIR}/etcd"
FILES_BACKUP_DIR="${BACKUP_DIR}/files"
LOG_FILE="/var/log/backup-k8s.log"

# Timestamp
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

# Filenames
ETCD_SNAPSHOT="${ETCD_BACKUP_DIR}/etcd-snapshot-${TIMESTAMP}.db"
FILES_ARCHIVE="${FILES_BACKUP_DIR}/k8s-files-${TIMESTAMP}.tar.gz"

log() {
    echo "[$(date +%Y-%m-%dT%H:%M:%S)] $*" | tee -a "$LOG_FILE"
}

log "==================================================================================================================================================================="
log "Backup started."

# Create directories if missing
mkdir -p "$ETCD_BACKUP_DIR" "$FILES_BACKUP_DIR"

# etcd Snapshot
log "Starting etcd snapshot to $ETCD_SNAPSHOT"
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save "$ETCD_SNAPSHOT"
log "etcd snapshot completed."

# Archive manifests and PKI
log "Archiving /etc/kubernetes/manifests and /etc/kubernetes/pki to $FILES_ARCHIVE"
tar -czf "$FILES_ARCHIVE" \
    /etc/kubernetes/manifests \
    /etc/kubernetes/pki
log "File archive completed."

# Cleanup
log "Cleaning up old etcd snapshots (>8 days)"
find "$ETCD_BACKUP_DIR" -type f -name "etcd-snapshot-*.db" -mtime +7 -delete

log "Cleaning up old file archives (>8 days)"
find "$FILES_BACKUP_DIR" -type f -name "k8s-files-*.tar.gz" -mtime +7 -delete

echo "[$(date +%Y-%m-%dT%H:%M:%S)] Disk usage: $(du -sh /mnt/wasabi)" | tee -a "$LOG_FILE"
log "Backup completed successfully."
