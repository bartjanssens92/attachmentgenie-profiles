# This class can be used install promtail
#
# @example when declaring the promtail class
#  class { '::profiles::monitoring::promtail': }
#
class profiles::monitoring::promtail (
  Stdlib::HTTPUrl $client_url,
  String[1] $checksum = '31ab57cd206f575e493755607e8f6163f3e860b9d176f10404d537fc1197835c',
  Stdlib::Absolutepath $positions_file = '/tmp/positions.yaml',
  Array $scrape_configs = [
    {
      'job_name' => 'system_secure',
      'static_configs' => [{
        'targets' => ['localhost'],
        'labels'  => {
          'job'  => 'var_log_secure',
          'host' => $::fqdn,
          '__path__' => '/var/log/secure'
        }
      }]
    },
    {
      'job_name' => 'system_messages',
      'static_configs' => [{
        'targets' => ['localhost'],
        'labels'  => {
          'job'  => 'var_log_messages',
          'host' => $::fqdn,
          '__path__' => '/var/log/messages'
        }
      }]
    },
    {
      'job_name' => 'journal',
      'journal' => {
        'max_age' => '12h',
        'labels' => {
          'job'  => 'systemd_journal',
          'host' => $::fqdn,
        }
      },
      'relabel_configs' => [
        {
          'source_labels' => ['__journal__systemd_unit'],
          'target_label' => 'unit',
        }
      ]
    }
  ],
  String[1] $version = 'v2.1.0',
) {

  $_clients_config_hash = { 'clients' => [{'url' => $client_url }]}
  $_positions_config_hash = { 'positions' => { 'filename' => $positions_file} }
  $_scrape_configs_hash = { 'scrape_configs' => $scrape_configs}
  class { '::promtail':
    checksum              => $checksum,
    clients_config_hash   => $_clients_config_hash,
    positions_config_hash => $_positions_config_hash,
    scrape_configs_hash   => $_scrape_configs_hash,
    server_config_hash    => { 'server' => { 'http_listen_port' => 9080 , 'grpc_listen_port' => 0}},
    service_ensure        => 'running',
    version               => $version,
  }
}
