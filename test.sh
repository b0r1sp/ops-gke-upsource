#!/usr/bin/env bash

# test script setup
testName=upsource-test
project=ops-iac-sb
zone=us-east1-b
clusterName=${testName}-cluster
domainName=${testName}.oks.lzy.sh
cleanup=true

# set environment
source setEnv.sh

# source in functions:
for file in ${functions}/*
do
        source ${file}
done

# depends
cmd="ops-common/gcloud/setConfig.sh -p ${project} -z ${zone}"
echoBlue "Running dependency: ${cmd}"
${cmd}
results

cmd="ops-common/gcloud/createK8sCluster.sh -c ${clusterName}"
echoBlue "Running dependency: ${cmd}"
${cmd}
results

# test createDisk.sh
cmd="./createDisk.sh"
${cmd}
results

# test start.sh
cmd="ops-common/kubectl/start.sh -a upsource -d ${domainName}"
${cmd}
results

# cleanup
cleanup=true
if [ "${cleanup}" = true ]; then
	cmd="kubectl delete ns upsource"
	echoBlue "Running cleanup command: ${cmd}"
        ${cmd}
	cmd="gcloud container clusters delete ${cluster}"
	echoBlue "Running cleanup command: ${cmd}"
        ${cmd}
	cmd="gcloud compute disks delete upsource-data upsource-backups upsource-logs upsource-conf"
	echoBlue "Running cleanup command: ${cmd}"
        ${cmd}
fi

# Fail overall script if any tests fail
if [ "${fail}" = true ]; then
        exit 1
fi
