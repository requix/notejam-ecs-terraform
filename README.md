# Notejam ECS Infrastructure

Implementation of Cloud Infrastructure for Notejam application

Features:
* High-availability (Multi-AZ)
* Loadbalanced (ALB)
* Isolated in a VPC
* Private -> Public access (NAT'd)
* Auto-scaling
* Multi-Environment configuration
* Terraform Remote State
* CI/CD workflow

## Prerequisites:

Before you begin, be sure you have installed next tools:
* AWS CLI
* Docker
* Terraform


## Setup environment variables

1. `cp .env.example .env`
2. Edit variables in .env file with proper values
3. `source .env`


## How to run Notejam Container locally

```bash
cd app
sh ./start.sh
```

Script `start.sh` contains instructions how to build and run application container locally.

```
//start.sh

#!/bin/bash

docker build -t notejam-flask .

docker run \
    -p 5007:5000 \
    --name notejam-app \
    notejam-flask \
    gunicorn notejam.wsgi:application --bind 0.0.0.0:5000
```    

Open http://localhost:5007/


## How to create and push container images to AWS ECR

* Authenticate to your default registry
`aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.AWS_REGION.amazonaws.com`

* Create repository in ECR for **application** container

```bash
aws ecr create-repository \
    --repository-name $APP_CONTAINER_NAME \
    --image-scanning-configuration scanOnPush=true \
    --region $AWS_REGION
```    

* Push an **app** image to Amazon ECR

```bash
cd app
docker build -t $AWS_ACCOUNT.dkr.ecr.eu-central-1.amazonaws.com/$APP_CONTAINER_NAME:latest .
docker push $AWS_ACCOUNT.dkr.ecr.eu-central-1.amazonaws.com/$APP_CONTAINER_NAME:latest
```

* Create repository in ECR for **nginx** container

```bash
aws ecr create-repository \
    --repository-name $NGINX_CONTAINER_NAME \
    --image-scanning-configuration scanOnPush=true \
    --region $AWS_REGION
```    

* Push an **nginx** image to Amazon ECR

```bash
cd nginx
docker build -t $AWS_ACCOUNT.dkr.ecr.eu-central-1.amazonaws.com/$NGINX_CONTAINER_NAME:latest .
docker push $AWS_ACCOUNT.dkr.ecr.eu-central-1.amazonaws.com/$NGINX_CONTAINER_NAME:latest
```

## How to deploy infrastructure via Terraform

* Specify `profile`, `region` and `availability_zones` variables in **terraform/config/prod.tfvars** or keep default values

* Run it (example for production environment)

```bash
env=prod
terraform init -backend-config=config/backend-${env}.conf
terraform plan -var-file=config/${env}.tfvars
terraform apply -var-file=config/${env}.tfvars
```
* Destroy infrastructure if needed

`terraform destroy -var-file=config/${env}.tfvars`