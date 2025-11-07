output "publicip" {
    value = aws_instance.public.public_ip  
}

output "privateip" {
    value = aws_instance.public.private_ip
}

output "pub__ec2_az" {
    value = aws_instance.public.availability_zone
  
}

output "pvt_ip_pvt_ec2" {
    value = aws_instance.private.private_ip
  
}
 output "pvt_ec2_az" {
    value = aws_instance.private.availability_zone
   
 }