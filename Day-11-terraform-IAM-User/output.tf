# ---------- Access Keys ----------
# output "access_key_id" {
#   value = aws_iam_access_key.name.id
# }

# output "secret_access_key" {
#   value     = aws_iam_access_key.name.secret
#   sensitive = true
# }

# ---------- IAM User ----------
output "console_username" {
  value = aws_iam_user.user1.name
}

output "console_password" {
  value     = aws_iam_user_login_profile.password.password
  sensitive = true
}

