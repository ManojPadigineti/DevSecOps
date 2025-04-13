cp /root/DevSecOps/Shell_scripts/mongo-db-ms/mongo.repo  /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
systemctl enable mongod
systemctl start mongod
systemctl restart mongod