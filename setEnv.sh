# environment setup
export functions="ops-common/functions"
gcloudDebug=false

# gcloud verbosity
if [ "${gcloudDebug}" = true ]; then
        export gcloud="gcloud -q --verbosity=debug"
else
        export gcloud="gcloud -q --verbosity=error --no-user-output-enabled"
fi

# test script setup
testName=upsource-test
project=ops-iac-sb
zone=us-east1-b
clusterName=${testName}-cluster
domainName=${testName}.ois.lzy.sh
cleanup=true