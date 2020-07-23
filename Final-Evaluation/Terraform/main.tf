# Providing the AWS Credentials
provider "aws" {
    profile    = "default"
    region     = var.region
    version    = "~> 2.12.0"
}

# Creating VPC
resource "aws_vpc" "My_VPC" {
    cidr_block           = var.vpcCIDRBlock
    instance_tenancy     = var.instanceTenancy
    enable_dns_support   = var.dnsSupport
    enable_dns_hostnames = var.dnsHostNames

    tags = {
        Name = var.vpcName
    }
}

# Creating IGW
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.My_VPC.id

  tags = {
      Name = var.InternetGateWay
  }
}

# Creating NAT Gateway
resource "aws_nat_gateway" "NAT" {
  allocation_id = var.elasticIP
  subnet_id     = aws_subnet.Public-Subnet-1.id
  depends_on    = [aws_internet_gateway.IGW]
}

# Using Data Source for retrieving AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating Public Subnets
resource "aws_subnet" "Public-Subnet-1" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = var.Public-Subnet-CIDR-1
    map_public_ip_on_launch = var.mapPublicIP

    tags = {
        Name = var.Public_Subnet_Name-1
    }

    availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "Public-Subnet-2" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = var.Public-Subnet-CIDR-2
    map_public_ip_on_launch = var.mapPublicIP

    tags = {
        Name = var.Public_Subnet_Name-2
    }
    
    availability_zone = data.aws_availability_zones.available.names[1]
}

# Creating Private Subnets
resource "aws_subnet" "App-Subnet-1" {
  vpc_id     = aws_vpc.My_VPC.id
  cidr_block = var.App-Subnet-CIDR-1
  tags = {
    Name = var.App_Subnet_Name-1
  }

  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "App-Subnet-2" {
  vpc_id     = aws_vpc.My_VPC.id
  cidr_block = var.App-Subnet-CIDR-2

  tags = {
    Name = var.App_Subnet_Name-2
  }

  availability_zone = data.aws_availability_zones.available.names[1]
}

# Defining the DB Subnets
resource "aws_subnet" "DB-Subnet-1" {
  vpc_id     = aws_vpc.My_VPC.id
  cidr_block = var.DB-Subnet-CIDR-1

  tags = {
    Name = var.DB_Subnet_Name-1
  }

  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "DB-Subnet-2" {
  vpc_id     = aws_vpc.My_VPC.id
  cidr_block = var.DB-Subnet-CIDR-2

  tags = {
    Name = var.DB_Subnet_Name-2
  }

  availability_zone = data.aws_availability_zones.available.names[1]
}

# Creating Route-Table for Public Subnet
resource "aws_route_table" "Public-Route" {
  vpc_id = aws_vpc.My_VPC.id

  route {
      cidr_block = var.destinationCIDR
      gateway_id = aws_internet_gateway.IGW.id
  }

  tags   = {
    Name = var.publicRouteTableName
  }
}

# Creating Route-Table Association for Public Subnets
resource "aws_route_table_association" "Public-Association-1" {
  route_table_id = aws_route_table.Public-Route.id
  subnet_id      = aws_subnet.Public-Subnet-1.id
}

resource "aws_route_table_association" "Public-Association-2" {
  route_table_id = aws_route_table.Public-Route.id
  subnet_id      = aws_subnet.Public-Subnet-2.id
}

# Creating Route-Table for Private Subnet
resource "aws_route_table" "Private-Route" {
  vpc_id = aws_vpc.My_VPC.id

  route {
    cidr_block     = var.destinationCIDR
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = var.privateRouteTableName-1
  }
}

# Associating Route-Table with Private
resource "aws_route_table_association" "Private-Assoc-1" {
  subnet_id      = aws_subnet.App-Subnet-1.id
  route_table_id = aws_route_table.Private-Route.id
}

# Associating Route-Table with Private
resource "aws_route_table_association" "Private-Assoc-2" {
  subnet_id      = aws_subnet.App-Subnet-2.id
  route_table_id = aws_route_table.Private-Route.id
}

resource "aws_route_table_association" "Private-Assoc-3" {
  subnet_id      = aws_subnet.DB-Subnet-1.id
  route_table_id = aws_route_table.Private-Route.id
}

resource "aws_route_table_association" "Private-Assoc-4" {
  subnet_id      = aws_subnet.DB-Subnet-2.id
  route_table_id = aws_route_table.Private-Route.id
}

# Security-Group
resource "aws_security_group" "application_sg" {
  vpc_id      = aws_vpc.My_VPC.id
  name        = "application_sg"
  description = "This Security Group for Application Server"

# Ingress Security Port 80
  ingress {
  cidr_blocks       = var.ingressCIDRBlock
  from_port         = var.ingress_http_from_Port
  to_port           = var.ingress_http_to_Port
  protocol          = var.ingressProtocol
 }

# Ingress Security Port 22
  ingress {
  cidr_blocks = var.ingress_ssh_cidr
  from_port   = var.ingress_SSH_from_Port
  to_port     = var.ingress_SSH_to_Port
  protocol    = var.protocol
 }

# Ingress Security Port 5000
ingress {
  cidr_blocks = var.ingressCIDRBlock
  from_port   = var.ingress_frontend_from_Port
  to_port     = var.ingress_frontend_to_Port
  protocol    = var.protocol
 }

# Ingress Security Port 8080-8083
  ingress {
    cidr_blocks = var.ingressCIDRBlock
    from_port   = var.ingress_application_from_port
    to_port     = var.ingress_application_to_port
    protocol    = var.protocol
  }

# All OutBound access
  egress {
  cidr_blocks       = var.egressCIDRBlock
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egressProtocol
 }
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = aws_vpc.My_VPC.id

  ingress {
    protocol    = var.bastion_ingress_protocol
    from_port   = var.bastion_ingress_from_port
    to_port     = var.bastion_ingress_to_port
    cidr_blocks = var.bastion_ingress_cidr
  }

  egress {
    protocol    = var.bastion_egress_protocol
    from_port   = var.bastion_egress_from_port
    to_port     = var.bastion_egress_to_port
    cidr_blocks = var.bastion_egress_cidr
  }
}

resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami
  key_name                    = var.key
  instance_type               = var.bastion_instance_type
  security_groups             = [aws_security_group.bastion-sg.id]
  subnet_id                   = aws_subnet.Public-Subnet-1.id
  associate_public_ip_address = true

  tags = {
    Name = var.bastion_name
  }
}

# Creating Load Balancer
# Creating Load-Balancer Security-group
resource "aws_security_group" "elb_SG" {
  name        = "elb"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id      = aws_vpc.My_VPC.id

  ingress {
    from_port   = var.ingress_http_from_Port
    to_port     = var.ingress_http_to_Port
    protocol    = var.ingressProtocol
    cidr_blocks = var.ingress_elb_CIDRBlock
  }

  egress {
    from_port       = var.egress_from_port
    to_port         = var.egress_to_port
    protocol        = var.egressProtocol
    cidr_blocks     = var.egressCIDRBlock
  }
}

resource "aws_elb" "ELB" {
  name = "aws-elb"
  security_groups = [aws_security_group.elb_SG.id]
  subnets = [
    aws_subnet.Public-Subnet-1.id,
    aws_subnet.Public-Subnet-2.id
  ]
  cross_zone_load_balancing   = var.crossZoneBalancing
  
  health_check {
    healthy_threshold   = var.healthyThreshold
    unhealthy_threshold = var.unhealthyThreshold
    timeout             = var.timeout
    interval            = var.interval
    target              = var.target
  }
  listener {
    lb_port           = var.lb_port
    lb_protocol       = var.lb_protocol
    instance_port     = var.instance_port
    instance_protocol = var.instance_protocol
  }
}

resource "aws_launch_configuration" "LaunchConfig" {
  name_prefix                 = "L_cfg"
  image_id                    = var.image
  instance_type               = var.instance_type
  key_name                    = var.key

  security_groups             = [aws_security_group.application_sg.id]
  associate_public_ip_address = var.publicIPAssociaton

  user_data = file("userdata.sh")

  lifecycle {
    create_before_destroy = true
  }
}

# Creating Auto Scaling Group
resource "aws_autoscaling_group" "ASG" {
  name                 = "asg"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1

  health_check_type    = var.healthCheckType
  load_balancers       = [aws_elb.ELB.id]

  launch_configuration = aws_launch_configuration.LaunchConfig.id
  
  vpc_zone_identifier  = [
    aws_subnet.App-Subnet-1.id,
    aws_subnet.App-Subnet-2.id
  ]

  depends_on = [aws_elb.ELB, aws_subnet.Public-Subnet-1, aws_subnet.Public-Subnet-2]
 
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = var.propagate_at_launch
  }
}

resource "aws_autoscaling_policy" "asg_policy_up" {
  name                   = "asg-policy-up"
  scaling_adjustment     = var.scalingIncrease
  adjustment_type        = var.adjustmentType
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.ASG.name
  depends_on             = [aws_autoscaling_group.ASG]
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_alarm_up" {
  alarm_name          = "cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = var.metricName
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = var.stats
  threshold           = var.Threshold_up

  alarm_actions = [aws_autoscaling_policy.asg_policy_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG.name
  }
}

resource "aws_autoscaling_policy" "asg_policy_down" {
  name                   = "asg-policy-down"
  scaling_adjustment     = var.scalingDecrease
  adjustment_type        = var.adjustmentType
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.ASG.name
  depends_on             = [aws_autoscaling_group.ASG]
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_alarm_down" {
  alarm_name          = "cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = var.metricName
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = var.stats
  threshold           = var.Threshold_down

  alarm_actions = [aws_autoscaling_policy.asg_policy_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG.name
  }
}

# Security-Group for Elastic Search Server
resource "aws_security_group" "ElasticSearch_sg" {
  vpc_id      = aws_vpc.My_VPC.id
  name        = "ElasticSearch_sg"
  description = "This is my ElasticSearch Server Security Group"

# Ingress Security Port 80
  ingress {
  cidr_blocks       = var.ingressCIDRBlock
  from_port         = var.ingress_http_from_Port
  to_port           = var.ingress_http_to_Port
  protocol          = var.ingressProtocol
 }

# Ingress Security Port 22
  ingress {
  cidr_blocks = var.ingressCIDRBlock
  from_port   = var.ingress_SSH_from_Port
  to_port     = var.ingress_SSH_to_Port
  protocol    = var.protocol
 }

# Ingress Security Port 9200
  ingress {
    cidr_blocks = var.ingressCIDRBlock
    from_port   = var.ingress_elastic_from_Port
    to_port     = var.ingress_elastic_to_Port
    protocol    = var.protocol
  }

# All OutBound access
  egress {
  cidr_blocks       = var.egressCIDRBlock
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egressProtocol
 }
}

# Creating EC2 instance for ElasticSearch
resource "aws_instance" "DB-1" {
  ami                         = var.amiID
  instance_type               = var.typeofInstance
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.available.names[0]
  count                       = var.instanceCount
  subnet_id                   = aws_subnet.DB-Subnet-1.id
 #user_data                   = file("userdata.sh")
  tenancy                     = var.tenancy
  monitoring                  = var.monitoring
  key_name                    = "ASGKEY"
  security_groups             = [aws_security_group.ElasticSearch_sg.id]

  tags = {
    Name = var.db_InstanceName-1
  }
}

# Security-Group for MySQL Server
resource "aws_security_group" "MySQL_sg" {
  vpc_id      = aws_vpc.My_VPC.id
  name        = "MySQL_sg"
  description = "This is my MySQL Server Security Group"

# Ingress Security Port 80
  ingress {
  cidr_blocks       = var.ingressCIDRBlock
  from_port         = var.ingress_http_from_Port
  to_port           = var.ingress_http_to_Port
  protocol          = var.ingressProtocol
 }

# Ingress Security Port 22
  ingress {
  cidr_blocks = var.ingressCIDRBlock
  from_port   = var.ingress_SSH_from_Port
  to_port     = var.ingress_SSH_to_Port
  protocol    = var.protocol
 }

# Ingress Security Port 3306
  ingress {
    cidr_blocks = var.ingressCIDRBlock
    from_port   = var.ingress_mysql_from_Port
    to_port     = var.ingress_mysql_to_Port
    protocol    = var.protocol
  }

# All OutBound access
  egress {
  cidr_blocks       = var.egressCIDRBlock
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egressProtocol
 }
}

# Creating EC2 Instance for MySQL
resource "aws_instance" "DB-2" {
  ami                         = var.amiID
  instance_type               = var.typeofInstance
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.available.names[1]
  count                       = var.instanceCount
  subnet_id                   = aws_subnet.DB-Subnet-2.id
 #user_data                   = file("userdata.sh")
  tenancy                     = var.tenancy
  monitoring                  = var.monitoring
  key_name                    = "ASGKEY"
  security_groups             = [aws_security_group.MySQL_sg.id]

  tags = {
    Name = var.db_InstanceName-2
  }
}


