# == Class nerve::params
#
# This class is meant to be called from nerve
# It sets variables according to platform
#
class nerve::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'nerve'
      $service_name = 'nerve'
    }
    'RedHat', 'Amazon': {
      $package_name = 'nerve'
      $service_name = 'nerve'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
