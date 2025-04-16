source /root/DevSecOps/shell_scripts/common.sh
app_name=mysql
password=RoboShop@1
install_dependencies $app_name
mysql_setup mysqld
