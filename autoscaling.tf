resource "aws_autoscaling_group" "gitlab_runner_asg" {
  for_each             = var.gitlab_runner_asg 
  desired_capacity     = each.value.desired_capacity
  max_size             = each.value.max_size
  min_size             = each.value.min_size
  vpc_zone_identifier  = [each.value.subnet_id]
  launch_template {
    id      = aws_launch_template.gitlab_runner["asg01"].id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "GitLab Runner ${each.key}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [ aws_launch_template.gitlab_runner ]
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.gitlab_runner_asg["runner01"].name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.gitlab_runner_asg["runner01"].name
}
