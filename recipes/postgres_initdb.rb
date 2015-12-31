

execute "Initilize Database" do
        command "rm -rf #{node['pgha']['data_path']} && /etc/init.d/postgresql-9.4 initdb"
        not_if "test -f #{node['pgha']['data_path']}/PG_VERSION"
end

