provider "spacelift" {
  # Ensure Spacelift provider is configured correctly
}

resource "spacelift_worker_pool" "private_pool" {
  name        = "private-worker-pool"
  description = "Private worker pool for running Terraform plans"
}

resource "aws_instance" "worker" {
  ami                    = "ami-12345678"  # Replace with the latest Amazon Linux AMI ID
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.worker_profile.name
  subnet_id              = "subnet-abcdefg" # Replace with your private subnet ID
  vpc_security_group_ids = ["sg-abcdefg"]   # Replace with your security group ID

  user_data = <<-EOF
              #!/bin/bash
              echo "SPACELIFT_WORKER_POOL=${spacelift_worker_pool.private_pool.id}" >> /etc/environment
              curl -fsSL https://downloads.spacelift.io/worker/install.sh | sh
              systemctl start spacelift-worker
              EOF
  tags = {
    Name = "Spacelift-Private-Worker"
  }
}

resource "aws_iam_instance_profile" "worker_profile" {
  name = "spacelift-worker-profile"
  role = aws_iam_role.worker_role.name
}

resource "aws_iam_role" "worker_role" {
  name = "spacelift-worker-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "worker_policy" {
  role       = aws_iam_role.worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Adjust permissions as needed
}
