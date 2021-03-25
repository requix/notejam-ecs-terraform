resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.cidrs)

  tags = {
    Name        = "${var.name}_${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}

resource "aws_route_table" "subnet" {
  vpc_id = var.vpc_id
  count  = length(var.cidrs)

  tags = {
    Name        = "${var.name}_${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "subnet" {
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = element(aws_route_table.subnet.*.id, count.index)
  count          = length(var.cidrs)
}