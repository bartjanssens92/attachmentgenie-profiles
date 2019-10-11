# This class is used to setup the incubator module on icingaweb2.
#
# It manages all the needed dependencies for setting up the incubator module
# and executes the kickstart.
#
# @example when including it
#   class { '::profiles::alerting::icingaweb2::incubator': }
#
class profiles::alerting::icingaweb2::incubator (
) inherits profiles::alerting::icingaweb2 {

  class {'icingaweb2::module::incubator':
    require => [
      Package['git'],
    ],
  }
}