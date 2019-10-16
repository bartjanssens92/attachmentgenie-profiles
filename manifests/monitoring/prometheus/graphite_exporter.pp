# Class to manage prometheus graphite exporter
#
# @example when declaring the carbon_relay class
#  class { '::profiles::monitoring::prometheus::graphite_exporter': }
#
class profiles::monitoring::prometheus::graphite_exporter (
  Boolean $manage_firewall_entry = true,
  Boolean $manage_sd_service = false,
  String $version = '0.6.2',
) {
  class { '::prometheus::graphite_exporter':
    version => $version,
  }

  if $manage_sd_service {
    ::profiles::orchestration::consul::service { 'graphite_exporter':
      checks => [
        {
          http     => 'http://localhost:9108',
          interval => '10s'
        }
      ],
      port   => 9108,
    }
    ::profiles::orchestration::consul::service { 'graphite':
      checks => [
        {
          http     => 'http://localhost:9109',
          interval => '10s'
        }
      ],
      port   => 9109,
    }
  }

  if $manage_firewall_entry {
    ::profiles::bootstrap::firewall::entry { '200 allow graphite exporter':
      port => 9108,
    }
    ::profiles::bootstrap::firewall::entry { '200 allow graphite':
      port => 9109,
    }
  }
}