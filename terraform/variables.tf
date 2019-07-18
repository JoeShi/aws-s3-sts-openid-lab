variable "app" {
  default = "demo"
}

variable "region" {
  default = "cn-north-1"
}

# Your local AWS credentials profile
variable "profile" {
  default = "zhy"
}

# Provider name, COPY from IAM Identity Provider Console，
# 如果是 Auth0， 最后一个 / 不能少
variable "providerName" {
  default = "aws-cognito.auth0.com/"
}

# Copy From Auth0
variable "domain" {
  default = "aws-cognito.auth0.com"
}

# OpenID Connect applcation clientID
variable "clientId" {
  default = "n4JmCUjAA4P7cEIEC3KI9yy8Kt4COqOt"
}
