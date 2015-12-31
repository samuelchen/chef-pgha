#
# configure slave node
#

include_recipe 'pgha::firewall'
include_recipe 'pgha::postgres'
include_recipe 'pgha::nfs'
include_recipe 'pgha::keepalived'

include_recipe 'pgha::slave_backup_restore_master'
include_recipe 'pgha::slave_configure'
include_recipe 'pgha::slave_finish'


