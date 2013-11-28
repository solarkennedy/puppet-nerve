# == Class nerve::params
#
# This class is meant to be called from nerve
# It sets variables according to platform
#
class nerve::params {
  case $::osfamily {
    'Debian','RedHat','Amazon': {
      $package_ensure   = 'present'
      # Allow logic to change based on requested provider
      $package_name     = undef
      $package_provider = undef
      $service_ensure   = 'running'
      $service_enable   = true
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
