install_dependencies () {
  for dependencies in $1
  do
  if [ $1 == "nginx" ]; then
    dnf module disable nginx -y
    dnf module enable nginx:1.24 -y
    dnf install nginx -y
  fi
  if [ $1 == "nodejs" ]; then
    dnf module disable nginx -y
    dnf module enable nginx:1.24 -y
    dnf install nginx -y
  fi
  done


#}
#}
#
#nodejs_install () {
#  dnf module disable nodejs -y
#  dnf module enable nodejs:20 -y
#  dnf install nodejs -y
#}
#nginx_install () {
#dnf module disable nginx -y
#dnf module enable nginx:1.24 -y
#dnf install nginx -y
#}
#
#
#systemd_setup () {
#  cp /root/DevSecOps/Shell_scripts/catalogue-ms/$app_name.service /etc/systemd/system/$app_name.service
#}