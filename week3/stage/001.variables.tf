# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

data "aws_ssm_parameter" "db_username" {
  name = "/tf/week3/db/username"
}

data "aws_ssm_parameter" "db_password" {
  name = "/tf/week3/db/password"
}

locals {
  db_username = data.aws_ssm_parameter.db_username
  db_password = data.aws_ssm_parameter.db_password
  db_name = "tstudydb"
}
