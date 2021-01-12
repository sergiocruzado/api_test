resource "aws_subnet" "private" {
  count = 3

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.all.names, count.index)

  tags = merge(local.tags, map("Name", format("%s-private-%s", local.tags["Name"], substr(element(data.aws_availability_zones.all.names, count.index), 8, 2))))

  # lifecycle {
  #   ignore_changes = [
  #     tags
  #   ]
  # }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = local.tags
}

resource "aws_route_table_association" "private" {
  count = 3

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "natgw" {
  vpc = true

  tags = local.tags
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw.id
  subnet_id     = aws_subnet.public[0].id

  tags = local.tags

  depends_on = [aws_internet_gateway.igw, aws_eip.natgw]
}