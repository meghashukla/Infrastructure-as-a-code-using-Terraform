#! /bin/bash
 sudo yum update -y
 sudo yum install -y httpd
 chkconfig httpd on
 echo"<h1><b>Assignment status : Submitted</b></h1>">/var/www/html/index.html
 sudo systemctl start httpd
 sudo systemctl enable httpd