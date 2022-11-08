provider "aws" {
  access_key = "AKIAYLDFKA3UYKBFQYOI"
  secret_key = "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"
  region     = var.region
}


##frontend modules

module "s3" {
  source                                    = "../../modules/s3"
  project_name                              = var.project_name
  environment                               = var.environment
  bucket_name                               = var.bucket_name
  cloudfront_origin_access_identity_oai_arn = module.cloudfront.cloudfront_origin_access_identity_oai_arn

}

module "s3_backend" {
  source       = "../../modules/s3_backup"
  project_name = var.project_name
  environment  = var.environment
  bucket_name  = var.bucket_name
}

module "cloudfront" {
  source                = "../../modules/cloudfront"
  environment           = var.environment
  web_panel_bucket      = module.s3.web_panel_bucket
  web_panel_domain_name = module.s3.web_panel_domain_name
  project_name          = var.project_name
  acm_arn               = var.acm_arn
  domain_name           = var.domain_name
}

##backend modules

module "alb" {
  source       = "../../modules/alb"
  project_name = var.project_name
  environment  = var.environment
  subnet_1     = var.subnet_1
  subnet_2     = var.subnet_2
  subnet_3     = var.subnet_3
  vpc          = var.vpc
}

module "cloudfront_backend" {
  source          = "../../modules/cloudfront_backend"
  environment     = var.environment
  cluster_lb      = module.alb.cluster_lb
  cluster_lb_dns  = module.alb.cluster_lb_dns
  project_name    = var.project_name
  acm_arn         = var.acm_arn
  api_domain_name = var.api_domain_name
}

module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
  environment  = var.environment
}

module "ecs" {
  source       = "../../modules/ecs"
  project_name = var.project_name
  environment  = var.environment
  acc_id       = var.acc_id
  region       = var.region
  api_sg       = module.sg.api_sg
  api_tg       = module.alb.api_tg
  subnet_1     = var.subnet_1
  subnet_2     = var.subnet_2
  subnet_3     = var.subnet_3
}

module "rds" {
  source               = "../../modules/rds"
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  project_name         = var.project_name
  environment          = var.environment
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  db_identifier        = var.db_identifier
  rds_db_sg            = module.sg.rds_db_sg
  subnet_1             = var.subnet_1
  subnet_2             = var.subnet_2
  subnet_3             = var.subnet_3
}

module "sg" {
  source       = "../../modules/sg"
  project_name = var.project_name
  environment  = var.environment
  vpc          = var.vpc
}
