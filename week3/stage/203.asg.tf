resource "aws_launch_configuration" "mylauchconfig" {
  name_prefix     = "t101-lauchconfig-"
  image_id        = data.aws_ami.my_amazonlinux2.id
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.mysg.id]
  associate_public_ip_address = true

  user_data = templatefile("./scripts/user-data.sh", {
    server_port = 8080
    db_address  = aws_db_instance.myrds.address
    db_port     = aws_db_instance.myrds.port
  })

  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "myasg" {

  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.myalbtg.arn]

  name                 = "myasg"
  launch_configuration = aws_launch_configuration.mylauchconfig.name
  vpc_zone_identifier  = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg"
    propagate_at_launch = true
  }
}

