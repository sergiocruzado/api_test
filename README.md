
Se pueden encontrar 3 carpetas diferentes:

- api_python: Aplicaciones dockerizadas, y el uso de docker-compose para probar en local.
- iac: donde esta el codigo de terraform (version 12) que despliega por un lado un cluster, y por otro un node_group
- k8s:  

## API_PYTHON:
Para desplegar las applicaciones python dockerizadas, a modo de prueba en un entorno local, se ha usado docker-compose.
Las applicaciones estan configuradas en: app1.localhost y app2.localhost cuando se despliegan con docker-compose

## IAC (TERRAFORM)
para desplegar la infraestructura hay que configurar en las variables el id de la cuenta y el alias ( el alias hace referencia al profile configurado en .aws/config )

si es necesario tambien esta la configuracion necesaria para desplegar el networking donde desplegar el EKS. En caso de no utilizarlo, habra que configurar los parametros de vpc_id y subnets_id.

con el fin de desplegar diferentes entornos con el mismo codigo se crea una carpeta environment y el fichero de variables dentro y se hace uso de la opcion --var-file displonible con la cli de terraform.

## K8S
Para separar los recursos hay creados 2 ficheros, uno para desplegar traefik y otro para desplegar whoami como ejemplo.
Para desplegar los recursos de k8s se ha usado kubectl

Sustituir en los ingress el valor de "hosts: ELB-ENDPOINT", por el dns personalizado o el dns publico del balanceador