module "vpc" {
  source = "./modules/vpc"
  name = "hello_vpc"
  vpc_cidr = "10.0.0.0/16"
  env = "dev"
  az_list = ["us-east-1a","us-east-1b"]
  private_subnets_list = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets_list = ["10.0.101.0/24", "10.0.102.0/24"]
  NAT = true

}

module "ec2" {
  source = "./modules/ec2"
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnet_id
}