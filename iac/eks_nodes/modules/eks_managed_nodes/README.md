# EKS Cluster

<!-- TF12DOC_START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_ca | The AMI Id for EKS Nodes | string | n/a | yes |
| cluster\_endpoint | The AMI Id for EKS Nodes | string | n/a | yes |
| cluster\_id | The AMI Id for EKS Nodes | string | n/a | yes |
| cluster\_name | The AMI Id for EKS Nodes | string | n/a | yes |
| cluster\_version | The version of k8s | string | n/a | yes |
| subnets\_id | List of subnets ID | list(string) | n/a | yes |
| vpc\_id | The VPC Id to deply the resources | string | n/a | yes |
| allow\_all\_egress |  | bool | `"true"` | no |
| allow\_all\_ingress |  | bool | `"true"` | no |
| image\_id | The AMI Id for EKS Nodes | string | `""` | no |
| instance\_type | The instance type for EKS Nodes | string | `"t3.medium"` | no |
| key\_pair\_name | The key pair name for accessing by SSH | string | `""` | no |
| kms\_key\_id | The KMS key Id | string | `""` | no |
| max\_capacity\_size | The maximun nodes | number | `"3"` | no |
| max\_pods | The AMI Id for EKS Nodes | string | `"5"` | no |
| min\_capacity\_size | The minimun nodes | number | `"2"` | no |
| nodes\_role\_arn | The Role ARN for EKS Nodes | string | `""` | no |
| root\_volume\_size | The root volume size | string | `"20"` | no |
| tags | Additional tags for resources | map(string) | `{}` | no |
| volume\_encryption | If use encription | bool | `"false"` | no |
| volume\_type | The root volume size | string | `"gp2"` | no |

<!-- TF12DOC_END -->
