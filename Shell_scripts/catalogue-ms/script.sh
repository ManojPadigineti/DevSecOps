cp /root/DevSecOps/Shell_scripts/catalogue-ms/catalogue.service /etc/systemd/system/catalogue.service
cp /root/DevSecOps/Shell_scripts/catalogue-ms/mongo.repo /etc/yum.repos.d/mongo.repo
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
id roboshop &>> /tnp/log.txt
if [ $? -ne 0 ]; then
  useradd roboshop
fi
ls /app &>> /tnp/log.txt
if [ $? -ne 0 ]; then
  mkdir /app
fi
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
dnf install mongodb-mongosh -y
mongosh --host 10.0.2.204 </app/db/master-data.js