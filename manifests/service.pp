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
  }

  if $osfamily == 'RedHat' and $operatingsystemmajrelease == 6 {
    service { 'nerve':
      ensure     => $nerve::service_ensure,
      enable     => false,
      hasstatus  => true,
      start      => '/sbin/initctl start nerve',
      stop       => '/sbin/initctl stop nerve',
      status     => '/sbin/initctl status nerve | grep "/running" 1>/dev/null 2>&1',
      subscribe  => File['/etc/init/nerve.conf'],
    }
  } else {
    service { 'nerve':
      ensure     => $nerve::service_ensure,
      enable     => $nerve::service_enable,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => File['/etc/init/nerve.conf'],
    }
  }

  $log_file = $nerve::log_file
  $nobody_group = $osfamily ? {
    'RedHat' => 'nobody',
    default  => 'nogroup',
  }

  file { $log_file:
    ensure => file,
    owner  => nobody,
    group  => $nobody_group,
    mode   => 660,
  }

}
