resource "aws_subnet" "public" {
  count = 3

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.all.names, count.index)

  map_public_ip_on_launch = true
  
  tags = merge(local.tags, map("Name", format("%s-public-%s", local.tags["Name"], substr(element(data.aws_availability_zones.all.names, count.index), 8, 2))))

  # lifecycle {
  #   ignore_changes = [
  #     tags
  #   ]
  # }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = local.tags
}

resource "aws_route_table_association" "public" {
  count = 3

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = local.tags
}

resource "aws_route" "public_default_igw" {
  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
