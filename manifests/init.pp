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
  $package_provider = $nerve::params::package_provider,
  $package_name     = $nerve::params::package_name,
  $service_ensure   = $nerve::params::service_ensure,
) inherits nerve::params {

  class { 'nerve::install': } ->
  class { 'nerve::config': } ~>
  class { 'nerve::service': } ->
  Class['nerve']

}
