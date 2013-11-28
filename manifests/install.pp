# == Class nerve::intall
#
class nerve::install {
  include nerve::params

  package { $nerve::params::package_name:
    ensure => present,
  }
}
