install_dependencies () {
 for dependencies in $@
  do
    if [ $dependencies == "nginx" ]; then
      dnf module disable nginx -y
      dnf module enable nginx:1.24 -y
      dnf install nginx -y
      systemd_start nginx
    fi
    if [ $dependencies == "nodejs" ]; then
      dnf module disable nginx -y
      dnf module enable nginx:1.24 -y
      dnf install nginx -y
      systemd_start nodejs
    fi
  done
}

systemd_start () {
  systemctl enable $1
  systemctl start $1
  systemctl restart $1
}

nginx_setup () {
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cp $PWD/nginx.conf /etc/nginx/nginx.conf
}