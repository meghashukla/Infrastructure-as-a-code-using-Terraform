output "vpc" {
  value = module.vpc.name
}

output "vpc_region" {
  value = module.vpc.region
}

output "subnet_private" {
  value =  module.subnet_private.name
}

output "subnet_private_id" {
  value =  module.subnet_private.id  
}

output "subnet_private_az" {
  value =  var.subnet_private_az  
}

output "subnet_public" {
  value =  module.subnet_public.name  
}

output "subnet_public_id" {
  value =  module.subnet_public.*.id  
}

output "security_group_internal" {
  value =  var.sg_internal  
}

output "security_group_internal_id" {
  value =  module.security_groups.internal_id  
}

output "security_group_public" {
  value =  var.sg_public  
}

output "security_group_public_id" {
  value =  module.security_groups.public_id  
}

output "instance_id" {
  value = module.webinstance.instanceid
}

