
package "Install NFS utilities" do
	package_name "nfs-utils"
	action :install
end

directory "#{node['pgha']['archive_path']}" do
	owner 'postgres'
	group 'postgres'
	mode '777'
	action :create
	not_if "test -d #{node['pgha']['archive_path']}"
end

mount node['pgha']['archive_path'] do
	device node['pgha']['nfs_path']
	fstype 'nfs'
	options ''
	action [:mount, :enable]
end

