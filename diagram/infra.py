from diagrams import Cluster, Diagram
from diagrams.aws.network import VPC
from diagrams.aws.network import PrivateSubnet
from diagrams.aws.network import PublicSubnet
from diagrams.aws.network import ELB
from diagrams.aws.network import NATGateway
from diagrams.aws.security import ACM
from diagrams.aws.network import Route53
from diagrams.aws.compute import AutoScaling
from diagrams.aws.compute import EC2
from diagrams.aws.compute import ECS
from diagrams.aws.compute import EC2ContainerRegistryRegistry
from diagrams.aws.compute import ElasticContainerServiceContainer
from diagrams.aws.compute import ElasticContainerServiceService
from diagrams.aws.database import Aurora
from diagrams.aws.database import AuroraInstance
from diagrams.onprem.iac import Terraform
from diagrams.onprem.ci import Circleci
from diagrams.onprem.container import Docker
from diagrams.aws.storage import S3

with Diagram("Notejam Cloud Infrastructure", show=False, direction="LR"):
    ssl_certificate = ACM("SSL Cert")
    dns_name = Route53("DNS Domain")
    load_balancer = ELB("Load Balancer")
    with Cluster("VPC"):
        with Cluster("Public Network"):
            public_subnets = [
                PublicSubnet("Subnet a"),
                PublicSubnet("Subnet b"),
                PublicSubnet("Subnet c"),
                ]            
            nat_gateways = [
                NATGateway("NAT Gateway a"),
                NATGateway("NAT Gateway b"),
                NATGateway("NAT Gateway c"),
                ]
            bastion_host = EC2("Bastion Host")
        with Cluster("Private Network"):
            private_subnets = [
                PrivateSubnet("Subnet a"),
                PrivateSubnet("Subnet b"),
                PrivateSubnet("Subnet c"),                
                ]
            with Cluster("ECS Cluster"):
                autoscaling_group = AutoScaling("Autoscaling Group")
                autoscaling_group_instances = [
                    EC2("EC2 Instance a"),
                    EC2("EC2 Instance b"),
                    EC2("EC2 Instance c"),
                ]
            with Cluster("Aurora Cluster"):
                aurora_endpoint = AuroraInstance("Aurora Endpoint")
                aurora_autoscaling_group_instances = [
                    Aurora("Primary Instance"),
                    Aurora("Aurora Replica"),
                    Aurora("Aurora Replica"),
                ]
                aurora_autoscaling_group = AutoScaling("Aurora Autoscaling")

    with Cluster("Container Service"):
        container_service = ECS("Amazon ECS")
        task = ElasticContainerServiceService("Tasks")
        app_container = ElasticContainerServiceContainer("Container (app)")
        nginx_container = ElasticContainerServiceContainer("Container (nginx)")

    with Cluster("Container Registry"):
        registry = EC2ContainerRegistryRegistry("Amazon ECR")
        app_image = Docker("Image (app)")
        nginx_image = Docker("Image (nginx)")

    ci_pipeline = Circleci("CI Pipeline")
    terraform_repo = Terraform("Infra as code")
    remote_state = S3("Remote State")

    ssl_certificate - dns_name
    dns_name - load_balancer
    load_balancer - public_subnets
    public_subnets[0] - nat_gateways[0]
    public_subnets[1] - nat_gateways[1]
    public_subnets[2] - nat_gateways[2]    
    nat_gateways[0] - private_subnets[0]
    nat_gateways[1] - private_subnets[1]
    nat_gateways[2] - private_subnets[2]
    public_subnets[0] - bastion_host
    bastion_host - private_subnets
    private_subnets - autoscaling_group
    autoscaling_group - autoscaling_group_instances
    autoscaling_group_instances - aurora_endpoint
    aurora_endpoint - aurora_autoscaling_group_instances
    aurora_autoscaling_group_instances - aurora_autoscaling_group
    app_image - registry
    nginx_image - registry
    container_service - app_container
    container_service - nginx_container
    container_service - task
    app_container - task
    nginx_container - task
    task - autoscaling_group_instances
    registry - container_service
    ci_pipeline - terraform_repo
    terraform_repo - remote_state
