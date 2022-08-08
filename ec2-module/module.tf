
##This will provision an EC2 instance
resource "aws_instance" "myserver1" {
  ami           = "ami-0b6937ac543fe96d7"
  instance_type = var.instance_type
  key_name = "firstkey"
  tags = {
    Name = "Jenkins-EC2"
  }
}

