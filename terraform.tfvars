aws-region = "us-east-1"
availibility_zones = ["us-east-1a", "us-east-1b"]
cluster_name = "my-test"
ssh_key_name = "id_rsa"

vpc_cidr = "172.16.0.0/16"
public_subnet_cidrs = ["172.16.0.0/24", "172.16.1.0/24"]
private_subnet_cidrs = ["172.16.50.0/24", "172.16.51.0/24"]

ec2_ami = "ami-6b4cc411"

database_name = "test"
database_user = "plsql"
database_password = "plsql1234"