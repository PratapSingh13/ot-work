# Variables for AWS Credentials
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "This is REGION for our Infrastructure"
}

# Variables for VPC
variable "vpcCIDRBlock" {
  type        = string
  default     = "10.0.0.0/16"
  description = "This is the CIDR Block for VPC"
}

variable "instanceTenancy" {
  type        = string
  default     = "default"
  description = "Taking Instance Tenancy"
}

variable "dnsSupport" {
  type        = bool
  default     = true
  description = "Want to take DNS Support"
}

variable "dnsHostNames" {
  type        = bool
  default     = true
  description = "Want to take DNS HostName"
}

variable "vpcName" {
  type        = string
  default     = "vpc-app"
  description = "This is your VPC name"
}

# Variables for Public Subnets
variable "mapPublicIP" {
    type    = bool
    default = true
}

variable "Public-Subnet-CIDR-1" {
    type        = string
    default     = "10.0.0.0/28"
    description = "The CIDR for PublicSubnet-1"
}

variable "Public_Subnet_Name-1" {
    type        = string
    default     = "PublicSubnet-1"
    description = "Name of our Public Subnet-1"
}

variable "Public-Subnet-CIDR-2" {
    type        = string
    default     = "10.0.0.16/28"
    description = "The CIDR for PublicSubnet-2"
}

variable "Public_Subnet_Name-2" {
    type        = string
    default     = "PublicSubnet-2"
    description = "Name of our Public Subnet-2"
}

# Variables for Private Subnets
variable "App-Subnet-CIDR-1" {
    type        = string
    default     = "10.0.0.32/28"
    description = "The CIDR for PrivateSubnet-1"
}

variable "App_Subnet_Name-1" {
    type        = string
    default     = "App_PrivateSubnet-1"
    description = "Name of our Private App Subnet-1"
}

variable "App-Subnet-CIDR-2" {
    type        = string
    default     = "10.0.0.48/28"
    description = "The CIDR for PrivateSubnet-2"
}

variable "App_Subnet_Name-2" {
    type        = string
    default     = "PrivateSubnet-2"
    description = "Name of our Private Subnet-2"
}

variable "DB-Subnet-CIDR-1" {
    type        = string
    default     = "10.0.0.64/28"
    description = "CIDR of Private-DB-Subnet-1"
}

variable "DB_Subnet_Name-1" {
    type        = string
    default     = "Private_DB_Subnet-1"
    description = "Name of Private DB subnet-1"
}

variable "DB-Subnet-CIDR-2" {
    type        = string
    default     = "10.0.0.80/28"
    description = "CIDR of Private-DB-Subnet-2"
}

variable "DB_Subnet_Name-2" {
    type        = string
    default     = "Private_DB_Subnet-2"
    description = "Name of Private DB subnet-2"
}

# Variables for Internet Gateway
variable "InternetGateWay" {
  type        = string
  default     = "IGW"
  description = "This is my Internet GateWay name"
}

# Variables for NAT Gateway
variable "elasticIP" {
  default     = "eipalloc-040a1bf771b0686e8"
  description = "This is ElasticIP will bound with NAT"
}

# Variables for Route Table of Public Subnet
variable "publicRouteTableName" {
    type        = string
    default     = "Public-Route"
    description = "A Route Table for Public Subnet"
}

variable "destinationCIDR" {
    type        = string
    default     = "0.0.0.0/0"
    description = "This is CIDR for Route Table"
}

# Variables for Route-Table of Private Subnet
variable "privateRouteTableName-1" {
    type        = string
    default     = "Priv-Route-1"
    description = "A Route Table for Private-Subnet-1"
}

# Variables for Security Group
# Variables for Port 80
variable "ingressCIDRBlock" {
    type    = list
    default = [ "10.0.0.0/28", "10.0.0.16/28", "10.0.0.32/28", "10.0.0.48/28", "10.0.0.64/28", "10.0.0.80/28", "10.0.0.96/28" ]
}

variable "ingress_http_from_Port" {
    default = "80"
}

variable "ingress_http_to_Port" {
    default = "80"
}

variable "ingressProtocol" {
    default = "tcp"
}

# Variables for Port 22
variable "ingress_ssh_cidr" {
    default = [ "0.0.0.0/0" ]
}
variable "ingress_SSH_from_Port" {
    default = "22"
}

variable "ingress_SSH_to_Port" {
    default = "22"
}

variable "protocol" {
    default = "tcp"
}

# Variable for Port 5000
variable "ingress_frontend_from_Port" {
    default = 5000
}

variable "ingress_frontend_to_Port" {
    default = 5000
}

# Variables for Port 8081
variable "ingress_application_from_port" {
    default = 8080
}

variable "ingress_application_to_port" {
    default = 8084
}

variable "egressCIDRBlock" {
    type    = list
    default = [ "0.0.0.0/0" ]
}

variable "egress_from_port" {
    default = "0"
}

variable "egress_to_port" {
    default = "0"
}

variable "egressProtocol" {
    default = "-1"
}

# Variables for Bastion
variable "bastion_ingress_protocol" {
    type    = string
    default = "tcp"
}

variable "bastion_ingress_from_port" {
    default = 22
}

variable "bastion_ingress_to_port" {
    default = 22
}

variable "bastion_ingress_cidr" {
    default = [ "0.0.0.0/0" ]
}

variable "bastion_egress_protocol" {
    default = -1
}

variable "bastion_egress_from_port" {
    default = 0
}

variable "bastion_egress_to_port" {
    default = 0
}

variable "bastion_egress_cidr" {
    default = [ "0.0.0.0/0" ]
}

variable "bastion_ami" {
    type        = string
    default     = "ami-0b44050b2d893d5f7"
    description = "This is ami-imageID of Ubuntu Server 18.04 LTS"
}

variable "bastion_instance_type" {
    type        = string
    default     = "t2.micro"
    description = "Selecting t2.micro type of instance"
}

variable "bastion_name" {
    type        = string
    default     = "Bastion"
    description = "Name of Bastion Server"
}

# Variables for ELB
variable "crossZoneBalancing" {
    type    = bool
    default = true
}

variable "ingress_elb_CIDRBlock" {
    default =[ "0.0.0.0/0" ]
}

# Variables for Health-Check of ELB
variable "healthyThreshold" {
    type    = number
    default = 10
}

variable "unhealthyThreshold" {
    type    = number
    default = 10
}

variable "timeout" {
    type    = number
    default = 3
}

variable "interval" {
    type    = number
    default = 30
}

variable "target" {
    type    = string
    default = "HTTP:80/"
}

# Variables for Listener of ELB
variable "lb_port" {
    type    = number
    default = 80
}

variable "lb_protocol" {
    type    = string
    default = "http"
}

variable "instance_port" {
    type    = number
    default = 80
}

variable "instance_protocol" {
    type    = string
    default = "http"
}

# Variables for Launch-Configuration
variable "image" {
    type        = string
    default     = "ami-0b44050b2d893d5f7"
    description = "This is ami-imageID of Ubuntu Server 18.04 LTS"
}

variable "instance_type" {
    type        = string
    default     = "t2.xlarge"
    description = "Selecting t2.micro type of instance"
}

variable "key" {
    type        = string
    default     = "ASGKEY"
    description = "Selecting key-pair"
}

variable "publicIPAssociaton" {
    type    = bool
    default = true
}

# Variables for Auto Scaling Group
variable "minimumSize" {
    type    = number
    default = 1
}

variable "maximumSize" {
    type    = number
    default = 4
}

variable "capacity" {
    type    = number
    default = 2
}

variable "healthCheckType" {
    type    = string
    default = "ELB"
}

variable "instance_name" {
    type    = string
    default = "ASG_LINUX"
}

variable "propagate_at_launch" {
    type    = bool
    default = true
}

# Variables for Auto-Scaling Policy
variable "scalingIncrease" {
    type    = number
    default = 1
}

variable "adjustmentType" {
    type    = string
    default = "ChangeInCapacity"
}

variable "cooldown" {
    type    = number
    default = 300
}

variable "scalingDecrease" {
    default = -1
}

# Variables for CloudWatch metric alarm
variable "metricName" {
    type    = string
    default = "CPUUtilization"
}

variable "period" {
    type    = number
    default = 120
}

variable "stats" {
    type    = string
    default = "Average"
}

variable "Threshold_up" {
    type    = number
    default = 80
}

variable "Threshold_down" {
    type    = number
    default = 70
}

# Variables for Database Instances
variable "db_InstanceName-1" {
    type        = string
    default     = "Elastic"
    description = "Providing name for our EC2 instance"
}

variable "db_InstanceName-2" {
    type        = string
    default     = "MySQL"
    description = "Providing name for our EC2 instance"
}

variable "typeofInstance" {
    type    = string
    default = "t2.medium"
}

variable "amiID" {
  default = "ami-0b44050b2d893d5f7"
}

variable "instanceCount" { 
  default = 1
  description = "Number of Instance to launch"
}

variable "tenancy" {
  default     = "default"
  description = "This is the Tenancy of the Instance"
}

variable "monitoring" {
  default     = false
  description = "This is regarding Monitoring of our Instance"
}

# Variables for Port 3306
variable "ingress_mysql_from_Port" {
    default = 3306
}

variable "ingress_mysql_to_Port" {
    default = 3306
}

variable "ingress_elastic_from_Port" {
    default = 9200
}

variable "ingress_elastic_to_Port" {
    default = 9200
}
