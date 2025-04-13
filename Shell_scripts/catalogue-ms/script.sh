cp /root/DevSecOps/Shell_scripts/catalogue-ms/catalogue.service /etc/systemd/system/catalogue.service
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
id roboshop
if [ $? -eq 0 ]; then
  useradd roboshop
fi
ls /app
if [ $? -eq 0 ]; then
  mkdir /app
fi
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
systemctl daemon-reload