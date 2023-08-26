output "public_subnet_id" {
  value = module.vpc.public_subnets[0]
}
