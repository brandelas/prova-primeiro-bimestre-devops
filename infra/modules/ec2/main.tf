resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = true
  iam_instance_profile        = var.instance_profile_name

  user_data = templatefile("${path.module}/user-data.sh.tftpl", {
    db_host     = var.db_host
    db_port     = var.db_port
    db_name     = var.db_name
    db_username = var.db_username
    db_password = var.db_password
  })

  tags = {
    Name    = "${var.project_name}-ec2"
    Project = var.project_name
  }
}