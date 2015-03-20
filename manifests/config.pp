# == Class nerve::config
#
# This class is called from nerve
#
class nerve::config {

  # TODO: something?
  # In the case were we are using the default location
  if $::nerve::config_file == $::nerve::params::config_file {
    # Make the parent directory
    file { '/etc/nerve/':
      ensure => 'directory',
    }
  }

  file { $::nerve::config_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('nerve/nerve.conf.json.erb'),
  }

  file { $::nerve::config_dir:
    ensure  => 'directory',
    recurse => true,
    purge   => $nerve::purge_config,
  }

}
