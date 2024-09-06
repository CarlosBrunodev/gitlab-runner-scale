resource "aws_iam_instance_profile" "gitlab_runner_instance_profile" {
  name = "gitlab-runner-instance-profile"
  role = "gitlab-runner" #Role existente
}

