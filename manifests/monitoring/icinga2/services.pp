#
# Wrapper around the icinga service object
#
define profiles::monitoring::icinga2::service (
  $target,
  $ensure                 = present,
  $service_name           = $title,
  $display_name           = undef,
  $host_name              = undef,
  $groups                 = undef,
  $vars                   = undef,
  $check_command          = undef,
  $max_check_attempts     = undef,
  $check_period           = undef,
  $check_timeout          = undef,
  $check_interval         = undef,
  $retry_interval         = undef,
  $enable_notifications   = undef,
  $enable_active_checks   = undef,
  $enable_passive_checks  = undef,
  $enable_event_handler   = undef,
  $enable_flapping        = undef,
  $enable_perfdata        = undef,
  $event_command          = undef,
  $flapping_threshold     = undef,
  $volatile               = undef,
  $zone                   = undef,
  $command_endpoint       = undef,
  $notes                  = undef,
  $notes_url              = undef,
  $action_url             = undef,
  $icon_image             = undef,
  $icon_image_alt         = undef,
  $apply                  = false,
  $prefix                 = false,
  $assign                 = [],
  $ignore                 = [],
  $import                 = [],
  $template               = false,
  $order                  = '60',
) {
  $_config_hash               => {
    $title                    => {
      'target'                => $target,
      'ensure'                => $ensure,
      'service_name'          => $service_name,
      'display_name'          => $display_name,
      'host_name'             => $host_name,
      'groups'                => $groups,
      'vars'                  => $vars,
      'check_command'         => $check_command,
      'max_check_attempts'    => $max_check_attempts,
      'check_period'          => $check_period,
      'check_timeout'         => $check_timeout,
      'check_interval'        => $check_interval,
      'retry_interval'        => $retry_interval,
      'enable_notifications'  => $enable_notifications,
      'enable_active_checks'  => $enable_active_checks,
      'enable_passive_checks' => $enable_passive_checks,
      'enable_event_handler'  => $enable_event_handler,
      'enable_flapping'       => $enable_flapping,
      'enable_perfdata'       => $enable_perfdata,
      'event_command'         => $event_command,
      'flapping_threshold'    => $flapping_threshold,
      'volatile'              => $volatile,
      'zone'                  => $zone,
      'command_endpoint'      => $command_endpoint,
      'notes'                 => $notes,
      'notes_url'             => $notes_url,
      'action_url'            => $action_url,
      'icon_image'            => $icon_image,
      'icon_image_alt'        => $icon_image_alt,
      'apply'                 => $apply,
      'prefix'                => $prefix,
      'assign'                => $assign,
      'ignore'                => $ignore,
      'import'                => $import,
      'template'              => $template,
      'order'                 => $order,
    }
  }

  ensure_resource( ::icinga2::objects::service, $_config_hash )
}
