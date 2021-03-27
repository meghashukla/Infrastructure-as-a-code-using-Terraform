module "security_groups" {
  source = "./modules/sg"

  vpc_id             = module.vpc.id
  vpc_region         = module.vpc.region
  sg_internal        = var.sg_internal
  sg_public          = var.sg_public
  subnet_public_cidr = var.subnet_public_cidr
  subnet_private_cidr = var.subnet_private_cidr
}

module "webinstance" {
  source = "./modules/ec2"
  subnet_id        = module.subnet_private.id
  ami              = var.amiid
  instance_type    = var.instance_type
  sg_id            = module.security_groups.internal_id
  instance_name    =var.instance_name
  rootvolumesize   = var.rootvolumesize
  rootvolumetype   = var.rootvolumetype
  kms_key_id       = module.kms.key_id
  key_name         = var.key_pair_name
}

module "kms" {
  source = "./modules/kms"
}

module "applicationloadbalancer" {
  source     = "./modules/alb"
  lb_name      =    var.alb_name
  alb_sg_id    =    module.security_groups.public_id
  alb_subnets  =    module.subnet_public.id
  vpc_id       =    module.vpc.id
  asg_id       =    module.autoscalinggroup.asg_id
  
 
}

module "ebsvolumes"{
  source  = "./modules/ebs"
  numberofvolumes = var.numberofvolumes
  ebsvolumeaz     = module.subnet_private.az
  ebsvolumesize   = var.ebsvolumesize
}

module "autoscalinggroup" {
  source = "./modules/asg"
  instance_name     = module.webinstance.instance_name
  instance_id       = module.webinstance.instanceid
  instance_type     = var.instance_type
  security_groups   = module.security_groups.internal_id
  key_name          = var.key_pair_name
  #subnetazs         = module.subnet_private.az
  min_size          = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity
  load_balancer_name= module.applicationloadbalancer.alb_id
  target_group_arn  = module.applicationloadbalancer.target_group_arn 
  subnet_ids        = module.subnet_private.id
}

module "snstopics" {
  source = "./modules/sns"
  display_name        =var.display_name  
  email_address       =var.email_address
  protocol            =var.protocol
}

module "cloudwatchalarms" {
  source = "./modules/cloudwatchalarm"
  max_5xx_errors    = var.max_5xx_errors
  instance_name     = var.instance_name
  load_balancer_arns= module.applicationloadbalancer.alb_id
  sns_topic_arn     = module.snstopics.sns_topic_id
}
