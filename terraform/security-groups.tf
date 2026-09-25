resource "aws_security_group" "alb" {
  name        = "wiz-now-alb-sg"
  description = "Security group for internet-facing load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wiz-now-alb-sg"
  }
}

resource "aws_security_group" "mongodb" {
  name        = "wiz-now-mongodb-sg"
  description = "Security group for MongoDB VM"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH - intentionally public for exercise"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MongoDB from Kubernetes private subnets"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [
      "10.0.11.0/24",
      "10.0.12.0/24"
    ]
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wiz-now-mongodb-sg"
  }
}
