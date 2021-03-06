provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.aws_web_sg.id]

  user_data = <<-EOF
	      #!/bin/bash
	      echo "Hellp Praveen" > index.html
	      nohup busybox httpd -f -p 8080 80 & 
	      EOF
  tags = {
    Name = "My_webServer"
}

}
resource "aws_security_group" "aws_web_sg" {
  name = "tf-web-sg"

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}













