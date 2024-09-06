resource "aws_launch_template" "gitlab_runner" {
  for_each      = var.gitlab_runner_launch-template
  name          = each.value.name
  image_id      = each.value.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.gitlab_runner_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = each.value.subnet_id
    security_groups             = [each.value.security_group_id]
  }

  user_data = base64encode(file("./scripts/init.sh"))
 

}
