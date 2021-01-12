#!/bin/bash

/etc/eks/bootstrap.sh  ${eks_cluster_id} \
 --b64-cluster-ca ${b64_cluster_ca} \
 --apiserver-endpoint ${eks_cluster_endpoint} \
 --kubelet-extra-args "--kube-reserved cpu=250m,memory=1Gi,ephemeral-storage=1Gi --system-reserved cpu=250m,memory=0.2Gi,ephemeral-storage=1Gi --eviction-hard memory.available<500Mi,nodefs.available<10% --max-pods=${max_pods}"


### por seguridad instalo esto, para pruebas futuras sin meter la parte de orange.
sudo yum install -y amazon-ssm-agent
sudo systemctl restart amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent

