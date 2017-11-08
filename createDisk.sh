#!/usr/bin/env bash

# check for environment config
if [ ! "${functions}" ] || [ ! "${gcloud}" ]; then
        echo "Environment not set"
        exit 1
fi

source ${functions}/checks.sh

# requirements
checkProgs gcloud

# gcloud work
gcloud compute disks create --size=50GB upsource-data
gcloud compute disks create --size=20GB upsource-backups
gcloud compute disks create --size=20GB upsource-logs
gcloud compute disks create --size=20GB upsource-conf