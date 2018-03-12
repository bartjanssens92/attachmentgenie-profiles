# This class can be used install influxdb
#
# @example when declaring the influxdb class
#  class { '::profiles::database::influxdb': }
#
# @param manage_repo Manage repositories.
#
# Influxdb module:
# https://github.com/dgolja/golja-influxdb.git
#
# Hieradata example:
#
# profiles::database::influxdb: true
# profiles::database::influxdb::manage_repo: true
#
# influxdb::graphite_config:
#   default:
#     enabled: false
# influxdb::retention_config:
#   enabled: true
#   check_interval: '10m0s'
# influxdb::http_config:
#   default:
#     enabled: true
#     bind-address: ':8086'
#     auth-enabled: true
#     log-enabled: true
#     https-enabled: false
#
class profiles::database::influxdb (
  Boolean $manage_repo = false,
){
  class {'::influxdb':
    graphite_config => {
        'default' => {
        'enabled'           => true,
        'database'          => 'graphite',
        'retention-policy'  => '',
        'bind-address'      => ':2003',
        'protocol'          => 'tcp',
        'consistency-level' => 'one',
        'batch-size'        => 5000,
        'batch-pending'     => 10,
        'batch-timeout'     => '1s',
        'udp-read-buffer'   => 0,
        'separator'         => '.',
        'tags'              => [],
        'templates'         => [],
      }
    },
  }

  if $manage_repo {
    include ::influxdb::repo
    Yumrepo['repos.influxdata.com'] -> Package['influxdb']
  }
}
