variable "aws_region" { default = "ap-south-1" }         # change if needed
variable "project"    { default = "node-crud-app" }
variable "app_port"   { default = 5000 }
variable "image_tag"  { default = "v1" }                 # change to deploy new versions
variable "vpc_cidr"   { default = "10.0.0.0/16" }
variable "mongo_uri"  { default = "" }                   # pass your Mongo URI (or blank if you'll set the secret out-of-band)
