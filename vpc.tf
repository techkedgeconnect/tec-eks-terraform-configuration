# Create a vpc module - Using the official AWS VPC module from the Terraform Registry.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 4.0.0"

  name                    = "${var.cluster_name}-vpc"
  cidr                    = var.vpc_cidr
  azs                     = data.aws_availability_zones.available.names
  public_subnets          = var.public_subnet_cidrs
  private_subnets         = var.private_subnet_cidrs
  enable_nat_gateway      = true
  single_nat_gateway      = true
  create_igw              = true
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.cluster_name}-vpc"
    Terraform   = "true"
    Environment = "tec-prod-workload-1"
  }
}
