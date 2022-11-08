region       = "ap-south-1"
project_name = "usp"
environment  = "stg"
subnet_1     = "subnet-0b594c9362ffad65d"
subnet_2     = "subnet-07b645b2f26b6574b"
subnet_3     = "subnet-0e5818d2d65817de8"
vpc          = "vpc-04822033decd807c6"

db_name              = "usp"
engine               = "postgres"
engine_version       = "14.3"
instance_class       = "db.t3.micro"
username             = "usp_admin"
password             = "rmJpVz0eYkPcUZpEZaIC"
parameter_group_name = "default.postgres14"
db_identifier        = "usp-db-stg"

bucket_name = "admin-panel"

acm_arn = "arn:aws:acm:us-east-1:573590603497:certificate/01a320fd-ee29-45fa-b464-a575b7769daa"

domain_name = "admin-stg.managalamcementusp.com"

api_domain_name = "api-stg.managalamcementusp.com"

acc_id = "573590603497"

web_panel_domain_name = "usp-admin-panel-stg.s3.ap-south-1.amazonaws.com"
web_panel_bucket      = "usp-admin-panel-stg.s3.ap-south-1.amazonaws.com"
