resource "aws_lb" "balancer" {
  name = "${var.cluster_name}-load-balancer"
  internal        = false
  subnets = ["${var.subnet_ids}"]
  security_groups = ["${var.sec_group_id}"]
  load_balancer_type = "application"

}

resource "aws_lb_target_group" "lb_tg" {
  name = "${var.cluster_name}-lb-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.lb_tg.arn}"
  target_id        = "${element(var.ec2_instance_ids, count.index)}"
  port             = 8080
  count            = "${var.ec2_instance_count}"
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = "${aws_lb.balancer.arn}"
  port              = "80"
  protocol          = "HTTP"


  default_action {
    target_group_arn = "${aws_lb_target_group.lb_tg.arn}"
    type             = "forward"
  }
}