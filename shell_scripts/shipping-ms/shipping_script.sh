source /root/DevSecOps/shell_scripts/common.sh
app_name=shipping
current_dir=$(PWD)
user=roboshop


install_dependencies maven
create_user $user
shipping_setup