variable first_number {
    type = number
    default = 5
}

locals { 
    # second_numbers = [for v in range(9) : tostring(v+1)] 
    second_numbers = [for v in range(9) : v+1 ] 
}


# resource "aws_security_group" "first_number" {
#     name        = "first_number"
#     description = "first_number"
#     vpc_id      = aws_vpc.main.id

#     ingress {
#         from_port        = 1
#         to_port          = 1
#         protocol         = "tcp"
#         cidr_blocks      = [aws_vpc.main.cidr_block]
#         description      = "first_number"
#     }

#     egress {
#         from_port        = 0
#         to_port          = 0
#         protocol         = "-1"
#         cidr_blocks      = ["0.0.0.0/0"]
#         ipv6_cidr_blocks = ["::/0"]
#     }
# }

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
