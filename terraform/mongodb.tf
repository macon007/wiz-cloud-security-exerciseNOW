resource "aws_instance" "mongodb" {
  ami           = "ami-0031a52699fcac15a"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public[0].id

  vpc_security_group_ids = [
    aws_security_group.mongodb.id
  ]

  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.mongodb.name
  tags = {
    Name = "wiz-now-mongodb"
  }
}
