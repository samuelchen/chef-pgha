#
# configure master node
#

include_recipe 'pgha::firewall'
include_recipe 'pgha::postgres'
include_recipe 'pgha::postgres_initdb'
include_recipe 'pgha::nfs'
include_recipe 'pgha::keepalived'

include_recipe 'pgha::master_configure'
include_recipe 'pgha::master_finish'
