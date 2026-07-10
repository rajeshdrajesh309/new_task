############################################
# RDS Subnet Group
############################################

resource "aws_db_subnet_group" "main" {
  name = "production-db-subnet-group"

  subnet_ids = [
    aws_subnet.private.id
  ]

  tags = {
    Name = "production-db-subnet-group"
  }
}

############################################
# RDS MySQL Instance
############################################

resource "aws_db_instance" "mysql" {

  identifier = "production-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  publicly_accessible = false

  skip_final_snapshot = true

  deletion_protection = false

  multi_az = false

  backup_retention_period = 7

  storage_encrypted = true

  tags = {
    Name = "production-mysql"
  }
}
