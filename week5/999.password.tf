# 그냥 한번 해봤습니다.

locals {
    md5_password = "161ebd7d45089b3446ee4e0d86dbcf92"
    sha1_password = "21bd12dc183f740ee76f27b78eb39c8ad972a757"
}

output md5_check {
    value = local.md5_password == md5(var.password) ? "pass":"fail"
    
}
output sha1_check {
    value = local.sha1_password == sha1(var.password) ? "pass":"fail"
}