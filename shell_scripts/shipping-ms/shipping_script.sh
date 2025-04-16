source /root/DevSecOps/shell_scripts/common.sh
app_name=shipping
current_dir=$(PWD)
user=roboshop

create_user $user
install_dependencies maven
shipping_setup