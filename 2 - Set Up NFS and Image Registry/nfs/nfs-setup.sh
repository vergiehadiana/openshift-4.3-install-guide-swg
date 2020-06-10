#!/bin/bash 

if [[ $# -ne 2 ]]; then
   echo "Usage: $(basename $0) <nfs server IP> <nfs data directory>"
   exit 1
fi

NFS_SEREVR_IP=$1
NFS_DATA_DIR=$2

sed -i -e "s/%NFS_SERVER%/${NFS_SEREVR_IP}/g" ./nfs-deployment.yaml
sed -i -e "s#%NFS_DATA_PATH%#${NFS_DATA_DIR}#g" ./nfs-deployment.yaml

kubectl -n default create -f ./nfs-deployment.yaml
kubectl -n default create -f ./nfs-storage-class.yaml
oc adm policy add-scc-to-user anyuid -z nfs-client-provisioner
kubectl -n default create -f ./nfs-cluster-role-binding.yaml

