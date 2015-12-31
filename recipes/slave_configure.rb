
template "#{node['pgha']['data_path']}/pg_hba.conf" do
	source 'pg_hba.erb'
	owner	'postgres'
	group	'postgres'
	mode 	'644'
        variables ({
                :user => node[:pgha][:replication][:user]
        })
end

template "#{node['pgha']['data_path']}/postgresql.conf" do
	source 'postgresql.erb'
	owner	'postgres'
	group	'postgres'
	mode 	'644'
	variables	({
		:archive_path => node[:pgha][:archive_path],
                :port => node[:pgha][:port]
	})
end

template "#{node['pgha']['data_path']}/recovery.conf" do
	source 'recovery.erb'
	owner	'postgres'
	group	'postgres'
	mode 	'644'
	variables	({
		:trigger_file => node['pgha']['failover']['trigger_file'] + '.B',
                :port => node[:pgha][:port],
		:rep_user => node[:pgha][:replication][:user],
		:rep_pwd => node[:pgha][:replication][:password],
                :slot => node[:pgha][:replication][:slot],
		:archive_path => node[:pgha][:archive_path]
	})
end


template "/etc/keepalived/keepalived.conf" do
        source 'keepalived.erb'
        owner   'postgres'
        group   'postgres'
        mode    '644'
        variables ({
                :dbvip => node['pgha']['keepalived']['dbvip'],
                :node_name => 'nodeB',
                :check_script => node['pgha']['keepalived']['check_script'],
                :notify_script => node['pgha']['keepalived']['notify_script'],
                :interval => node['pgha']['keepalived']['interval'],
                :interface => node['pgha']['keepalived']['interface'],
                :virtual_router_id => node['pgha']['keepalived']['virtual_router_id'],
                :priority => 90
        })
end

template "#{node['pgha']['keepalived']['check_script']}" do
        source 'check-postgres.erb'
        owner   'postgres'
        group   'postgres'
        mode    '755'
end


template "#{node['pgha']['keepalived']['notify_script']}" do
        source 'notify-fault.erb'
        owner   'postgres'
        group   'postgres'
        mode    '644'
        variables ({
                :trigger_file => node['pgha']['failover']['trigger_file'] + '.A'
        })
end
