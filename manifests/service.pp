# == Class nerve::service
#
# This class is meant to be called from nerve
# It ensure the service is running
#
class nerve::service {

  # TODO: This assumes upstart. Be more compatible someday

  $config_file = $nerve::config_file
  file { '/etc/init/nerve.conf':
    owner   => 'root',
    group   => 'root',
    mode    => 0444,
    content => template('nerve/nerve.conf.upstart.erb'),
  } ~>
  service { 'nerve':
    ensure     => $nerve::service_ensure,
    enable     => $nerve::service_enable,
    hasstatus  => true,
    hasrestart => true,
    provider   => upstart,
  }

}
