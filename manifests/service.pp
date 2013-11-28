# == Class nerve::service
#
# This class is meant to be called from nerve
# It ensure the service is running
#
class nerve::service {
  include nerve::params

  service { $nerve::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
