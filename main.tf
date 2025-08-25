resource "aws_instance" "app_server" {
  ami           = "ami-04ec97dc75ac850b1" # Ubuntu 22.04 LTS (Paris)
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name      = var.key_name

  tags = {
    Name = "Sapna_appserver"
  }

  # user_data = <<-EOF
  #             #!/bin/bash
  #             apt update -y
  #             apt install -y nginx
  #             echo "Hello from Student App Server" > /var/www/html/index.html
  #             systemctl start nginx
  #             systemctl enable nginx
  #             EOF
}

# Output public IP
output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}