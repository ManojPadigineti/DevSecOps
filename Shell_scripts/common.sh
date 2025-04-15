install_dependencies () {
 for dependencies in $@
  do
    if [ $dependencies == "nginx" ]; then
      dnf module disable nginx -y
      dnf module enable nginx:1.24 -y
      dnf install nginx -y
      nginx_setup
      systemd_start nginx
    fi
    if [ $dependencies == "nodejs" ]; then
      dnf module disable nginx -y
      dnf module enable nginx:1.24 -y
      dnf install nginx -y
      systemd_start nodejs
    fi
    if [ $dependencies == "mongodb" ]; then
      dnf install mongodb-org -y
      sed -i -e 's\127.0.0.1\0.0.0.0\g' /etc/mongod.conf
      systemd_start mongod
    fi
  done
}

systemd_start () {
  systemctl enable $1
  systemctl start $1
  systemctl restart $1
}

nginx_setup () {
ls /usr/share/nginx/html/* ;
   if [ $? -eq 0 ]; then
     rm -rf /usr/share/nginx/html/*
   fi
 ls /tmp/frontend.zip
   if [ $? -eq 0 ]; then
     rm -rf /tmp/frontend.zip
   fi
 curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
 cd /usr/share/nginx/html
 unzip /tmp/frontend.zip
 cd $current_dir
 ls /etc/nginx/nginx.conf
   if [ $? -eq 0 ]; then
     rm -rf /etc/nginx/nginx.conf
   fi
 cp -R nginx.conf /etc/nginx/nginx.conf
}
