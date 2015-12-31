# encoding: UTF-8

default['pgha']['master_ip'] = ''
default['pgha']['salve_ip'] = []
default['pgha']['port'] = 5432


default['pgha']['data_path'] = '/var/lib/pgsql/9.4/data'
default['pgha']['nfs_path'] = '192.168.2.11:/root/pgarchive'
default['pgha']['archive_path'] = '/var/lib/pgsql/9.4/pgarchive'

default['pgha']['replication']['user'] = 'repuser'
default['pgha']['replication']['password'] = 'repuser'
default['pgha']['replication']['slot'] = 'propel'

default['pgha']['keepalived']['dbvip'] = '192.168.2.72/24'
default['pgha']['keepalived']['check_script'] = 'check-postgres.sh'
default['pgha']['keepalived']['notify_script'] = 'notify-fault.sh'
default['pgha']['keepalived']['interval'] = '3'
default['pgha']['keepalived']['interface'] = 'eth0'
default['pgha']['keepalived']['virtual_router_id'] = '81'

# trigger file need to add extension be identify which node to be triggered.
default['pgha']['failover']['trigger_file'] = default['pgha']['archive_path'] + '/pg_failover.propel'
#'/var/lib/pgsql/9.4/pgarchive/pg_failover.propel.A'

