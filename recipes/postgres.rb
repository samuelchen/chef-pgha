#
# recipe to install postgres 9.4 on centos
#

service "Stop PostgreSQL Service if Started." do
	service_name 'postgresql-9.4'
	action :stop
	ignore_failure true
end

# In PROD, need to change to PROD repo
execute "Install PostgreSQL 9.4 Repository" do
	command 'yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-redhat94-9.4-1.noarch.rpm'
	not_if 'test -f /etc/yum.repos.d/pgdg-94-redhat.repo'
end

package "Install PostgreSQL 9.4 server" do
	package_name 'postgresql94-server'
	action :install
end

package "Install PostgreSQL 9.4 contrib" do
	package_name 'postgresql94-contrib'
	action :install
end



