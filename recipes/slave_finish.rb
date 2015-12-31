
service 'postgresql-9.4' do
        action [:start, :enable]
end

service 'keepalived' do
	action [:start, :enable]
end
