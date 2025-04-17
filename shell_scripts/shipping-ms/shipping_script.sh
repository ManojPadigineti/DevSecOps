app_name=shipping
current_dir=$(pwd)
source $current_dir/../common.sh
user=roboshop

create_user $user
install_dependencies maven
shipping_setup