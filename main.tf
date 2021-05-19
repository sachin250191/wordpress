provider "aws" {
  version    = "~> 2.70"
  region     = "us-east-2"

}


resource "aws_instance" "web" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  user_data     = data.template_file.web.redenderd
  tags = {
    Name = "web"
  }
}



data "template_file" "web" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    db_name = var.db_name
    db_pass = var.db_pass
    db_user = var.db_user
    db_host = aws_db_instance.wordpress.address
    efs_id  = aws_efs_file_system.wordpress-efs.id
  }
}
