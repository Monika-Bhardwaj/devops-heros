module "eks" {
  source="terraform-aws-modules/eks/aws"
  version="~> 20.0"
  cluster_name=var.cluster_name
  cluster_version="1.31"
  cluster_endpoint_public_access=true
  enable_cluster_creator_admin_permissions=true
  vpc_cidr="10.42.0.0/16"
  azs=["${var.aws_region}a","${var.aws_region}b","${var.aws_region}c"]
  private_subnets=["10.42.1.0/24","10.42.2.0/24","10.42.3.0/24"]
  public_subnets=["10.42.101.0/24","10.42.102.0/24","10.42.103.0/24"]
  enable_nat_gateway=true
  single_nat_gateway=true
  eks_managed_node_groups={default={instance_types=[var.node_instance_type],desired_size=var.desired_nodes,min_size=1,max_size=4,capacity_type="ON_DEMAND"}}
  tags={Project="final-devops-project",Environment="learning"}
}
