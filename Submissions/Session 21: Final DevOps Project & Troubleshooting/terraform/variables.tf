variable "aws_region" { type=string default="ap-south-1" }
variable "cluster_name" { type=string default="final-devops-eks" }
variable "node_instance_type" { type=string default="t3.small" }
variable "desired_nodes" { type=number default=2 }
