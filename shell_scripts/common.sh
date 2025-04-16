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
      dnf module disable nodejs -y
      dnf module enable nodejs:20 -y
      dnf install nodejs -y
    fi
    if [ $dependencies == "mongodb" ]; then
      mongo_setup
      dnf install mongodb-org -y
      sed -i -e 's\127.0.0.1\0.0.0.0\g' /etc/mongod.conf
      systemd_start mongod
    fi
    if [ $dependencies == "mongodb-mongosh" ]; then
      mongo_setup
      dnf install mongodb-mongosh -y
    fi
  done
}

systemd_start () {
  systemctl daemon-reload
  systemctl enable $1
  systemctl start $1
  systemctl restart $1
}

nginx_setup () {
current_dir=$(pwd)
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
 pwd
 ls /etc/nginx/nginx.conf
   if [ $? -eq 0 ]; then
     rm -rf /etc/nginx/nginx.conf; cp -R "$current_dir/nginx.conf" /etc/nginx/nginx.conf
   else
     cp "$current_dir/nginx.conf" /etc/nginx/nginx.conf
   fi
}

mongo_setup () {
cp -R $current_dir/mongo.repo /etc/yum.repos.d/mongo.repo
}

create_user () {
useradd $1
}

catalogue_setup () {
ls /app
 if [ $? -eq 0 ]; then
   rm -rf /app
 fi
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app ; unzip /tmp/catalogue.zip ; npm install
ls /etc/systemd/system/catalogue.service
 if [ $? -eq 0 ]; then
   rm -rf /etc/systemd/system/catalogue.service
 fi
cp -r $current_dir/catalogue.service /etc/systemd/system/catalogue.service
}