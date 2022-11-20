variable first_number {
    type = number
    default = 5
}

locals { 
    second_numbers = [for v in range(9) : v+1 ] 
}

resource "aws_security_group" "result" {
    name        = "result"
    description = "result"
    vpc_id      = aws_vpc.main.id

    dynamic "ingress" {
        for_each = local.second_numbers

        content {
            from_port        = tostring(var.first_number * ingress.value)
            to_port          = tostring(var.first_number * ingress.value)
            protocol         = "tcp"
            cidr_blocks      = [aws_vpc.main.cidr_block]
            description      = "${var.first_number} * ${ingress.value} = ${tostring(var.first_number * ingress.value)}"
        }
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}
