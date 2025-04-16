source /root/DevSecOps/shell_scripts/common.sh
install_dependencies nodejs
create_user roboshop
current_dir=$(pwd)
app_name=user
systemd_start $app_name

