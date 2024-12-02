variable "name" {
  description = "The name of the VPC"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  defualt     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "private_subnets" {
  description = "A list of private subnet IPs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "A list of public subnet IPs"
  type        = list(string)
  default     = ["10.0.64.0/24", "10.0.65.0/24", "10.0.66.0/24"]
}

variable "database_subnets" {
  description = "A list of database subnet IPs"
  type        = list(string)
  default     = ["10.0.128.0/24", "10.0.129.0/24", "10.0.130.0/24"]
}

variable "enable_nat_gateway" {
  description = "A boolean to enable NAT Gateways"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "A boolean to enable VPN Gateways"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean to enable DNS hostnames"
  type        = bool
  default     = true
}
