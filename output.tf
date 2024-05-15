output "network" {
  value = module.vpc.network.network_name
}
output "subnet" {
  value = module.vpc.subnets_names[0]
}
output "secondary-subnet" {
  value = module.vpc
}
