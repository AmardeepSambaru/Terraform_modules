# To Create vpc
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
}

# To Create subnet
resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
}

# To Create internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

# To create elastic ip for nat gate way
resource "aws_eip" "this" {
  vpc      = var.vpc
}

# To Create nat gateway
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.this.id
  depends_on = [aws_internet_gateway.this]
}

# To Create route table for public subnet
resource "aws_route_table" "this_public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.this.id
  }

}

# To Create route table for private subnet
resource "aws_route_table" "this_private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.route_cidr_block
    nat_gateway_id = aws_nat_gateway.this.id
  }
}

# attach route table and subnet 
resource "aws_route_table_association" "this_public" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this_public.id
}

resource "aws_route_table_association" "this_private" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this_private.id
}

