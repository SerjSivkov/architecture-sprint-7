# сначала нужны неймспейсы
./configure_kube/create_namespaces.sh
# далее создаем роли в созданных неймспейсах
./configure_kube/create_roles.sh
# далее связываем роли с группами
./configure_kube/create_role_bindings.sh
# заводим юзеров с такими группами
./configure_kube/create_users.sh
