#!/bin/bash

# Update all packages

sudo yum update -y
sudo yum install -y httpd
sudo service httpd start
sudo start httpd
