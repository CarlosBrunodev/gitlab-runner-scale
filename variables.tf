variable "gitlab_runner_asg" {
    description = "Mapa de objetos de variaveis para definicao de um AutoScaling Group para ser registrado como Runner no Gitlab"
    type = map(object({
      desired_capacity   = optional(number,"2")
      max_size           = optional(number,"5")
      min_size           = optional(number,"1")
      subnet_id          = string
      
    }))
  
}

variable "gitlab_runner_launch-template" {
    description = "Mapa de objetos de variaveis para definicao de um Launch template"
    type = map(object({
      name                = string
      ami_id              = optional(string,"")
      instance_type       = optional(string,"")
      key_name            = string
      subnet_id           = string
      security_group_id   = string
      gitlab_runner_url   = string
      gitlab_runner_token = string
      iam_istance_profile = optional(string,"")
    }))
  
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "sys"
}