resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = element(var.azs, index(var.public_subnets, each.value))
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name                     = "${var.name}-public-${each.value}"
      "kubernetes.io/role/elb" = "1"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = element(var.azs, index(var.private_subnets, each.value))

  tags = merge(
    {
      Name                              = "${var.name}-private"
      "kubernetes.io/role/internal-elb" = "1"
    },
    var.tags
  )
}
