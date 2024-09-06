output "launch_template_id" {
  value = [ for k,v in aws_launch_template.gitlab_runner : v.id]
}

output "autoscaling_group_name" {
  value = [ for k,v in aws_autoscaling_group.gitlab_runner_asg : v.name]
}
