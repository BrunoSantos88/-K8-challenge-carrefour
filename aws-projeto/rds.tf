resource "aws_db_instance" "developer" {
  identifier                = "developer"
  allocated_storage         = 50
  availability_zone         = "us-east-1a"
  engine                    = "mysql"
  engine_version            = "8.0.30"
  instance_class            = var.rds_instance_type
  db_subnet_group_name      = aws_db_subnet_group.networkinsdb.id
  vpc_security_group_ids    = []
  name                      = "kubenews"
  username                  = var.admin
  password                  = var.senha
  skip_final_snapshot       = true
  storage_type              = "gp2"
  port                      = "3306"
  final_snapshot_identifier = "Ignore"
}