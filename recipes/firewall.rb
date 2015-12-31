#
# diable firewall. cookbook 'pgha'
#

service "iptables" do
	action [:stop, :disable]
end
