output "vpc-id" {
  value = aws_vpc.main.id
}
output "sub1" {
  value = aws_subnet.subnet1.id
}
output "sub2" {
  value = aws_subnet.subnet2.id
}
output "pub1" {
  value = aws_subnet.main-public-1.id
}
output "pub2" {
  value = aws_subnet.main-public-2.id
}
