# EKS Cluster

<!-- TF12DOC_START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name | The name of the EKS Cluster | string | n/a | yes |
| cluster\_version | The version of k8s | string | n/a | yes |
| subnets\_id | List of subnets ID | list(string) | n/a | yes |
| vpc\_id | The VPC Id to deply the resources | string | n/a | yes |
| allow\_all\_egress |  | bool | `"true"` | no |
| allow\_all\_ingress |  | bool | `"true"` | no |
| cluster\_enabled\_log\_types | A list of the desired control plane logging to enable. Possible values ->"api","audit","authenticator","controllerManager","scheduler" | list | `[ "api", "audit", "authenticator" ]` | no |
| enable\_private\_access |  | bool | `"true"` | no |
| enable\_public\_access |  | bool | `"true"` | no |
| tags | Additional tags for resources | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_ca |  |
| cluster\_endpoint |  |
| cluster\_iam\_role\_arn |  |
| cluster\_id |  |
| cluster\_name |  |
| cluster\_sg\_id |  |

<!-- TF12DOC_END -->
