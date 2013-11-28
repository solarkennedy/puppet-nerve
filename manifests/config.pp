# == Class nerve::config
#
# This class is called from nerve
#
class nerve::config {

  file { $::nerve::config_file:
    ensure  => 'present',
    owner   => 'root',
    mode    => 0444,
    content => template('nerve/nerve.conf.json.erb'),
  }

  file { $::nerve::config_dir:
    ensure       => 'directory',
    recurse      => true,
    recurselimit => '1',
    purge        => $nerve::purge_config,
  }

}
