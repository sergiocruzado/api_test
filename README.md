# How To Deploy this API.


1 - Deploy terraform code iac/network, iac/eks_cluster and finally iac/eks_nodes.
2 - Save the kubeconfig. terraform output kubeconfig > ~/.kube/config once iac/eks_cluster is deployed
3 - And run make deploy

Traefik runs in port 8080
Api run in port 80

json example for post: {"name":"whatever","surname":"whatever"}
