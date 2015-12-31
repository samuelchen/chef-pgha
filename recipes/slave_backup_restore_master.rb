

execute "Remove Data Folder if Existed" do
        command "rm -rf #{node['pgha']['data_path']}"
        only_if "test -d #{node['pgha']['data_path']}"
end


execute 'Backup & Restore Master DB' do
	command "sudo -u postgres pg_basebackup --dbname=\"postgresql://#{node['pgha']['replication']['user']}:#{node['pgha']['replication']['password']}@#{node['pgha']['master_ip']}/\" -D #{node['pgha']['data_path']} -P --xlog-method=stream"
end


execute "Remove pg_xlog" do
	command "rm #{node['pgha']['data_path']}/pg_xlog/* -rf"
	ignore_failure true
end

execute "Remove recover.done which from master" do
	command "rm #{node['pgha']['data_path']}/recovery.done"	
	only_if "test -f #{node['pgha']['data_path']}/recovery.done"
end

