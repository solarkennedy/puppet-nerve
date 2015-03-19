# == Class: nerve
#
# Full description of class nerve here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class nerve (
  $package_ensure   = $nerve::params::package_ensure,
  $package_provider = $nerve::params::package_provider,
  $package_name     = $nerve::params::package_name,
  $service_ensure   = $nerve::params::service_ensure,
  $service_enable   = $nerve::params::service_enable,
  $config_file      = $nerve::params::config_file,
  $config_dir       = $nerve::params::config_dir,
  $purge_config     = $nerve::params::purge_config,
  $log_file         = $nerve::params::log_file,
  $instance_id      = $nerve::params::instance_id
) inherits nerve::params {

  class { 'nerve::install': } ->
  class { 'nerve::config': } ~>
  class { 'nerve::service': } ->
  Class['nerve']

}
