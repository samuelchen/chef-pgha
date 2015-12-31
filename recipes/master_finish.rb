
service 'postgresql-9.4' do
        action [:start, :enable]
end

execute 'Add Replication User to Master' do
	command "psql -U postgres -c \"create user #{node['pgha']['replication']['user']} replication login connection limit 3 encrypted password '#{node["pgha"]["replication"]["password"]}';\""
	only_if "test 0 -eq `psql -U postgres -t -c \"select count(rolname) from pg_roles where rolname='#{node['pgha']['replication']['user']}';\"`"
	
end

execute 'Create Replication Slot' do
	command "psql -U postgres -c \"select * from pg_create_physical_replication_slot('#{node["pgha"]["replication"]["slot"]}');\""
	only_if "test 0 -eq `psql -U postgres -t -c \"select count(slot_name) from pg_replication_slots where slot_name='#{node['pgha']['replication']['slot']}';\"`"
end


service 'keepalived' do
	action [:start, :enable]
end
