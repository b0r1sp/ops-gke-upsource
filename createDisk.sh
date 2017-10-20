#!/usr/bin/env bash

# source in environment and functions
source setEnv.sh
source ${functions}/checks.sh

checkProgs gcloud

# gcloud work
gcloud compute disks create --size=50GB upsource-data
gcloud compute disks create --size=20GB upsource-backups
gcloud compute disks create --size=20GB upsource-logs
gcloud compute disks create --size=20GB upsource-conf
