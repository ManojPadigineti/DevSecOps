# Catalogue Microservice Script
source /root/DevSecOps/shell_scripts/common.sh
app_name=catalogue
user=roboshop
current_dir=/root/DevSecOps/Shell_scripts/$app_name-ms

install_dependencies nodejs
create_user $user
catalogue_setup
systemd_start $app_name
install_dependencies mongodb-mongosh
mongosh --host 52.70.249.91 </app/db/master-data.js