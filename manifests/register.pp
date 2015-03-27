# == Define: nerve::register
#
# Sets up a nerve configuration file to register a particular service
#
# == Parameters
#
# [*port*]
#   Port on the local side that the service is exposing. No default.
#
define nerve::register (
  $port,
  $ensure         = 'present',
  $host           = '127.0.0.1',
  $zk_hosts       = ["localhost:2181"],
  $zk_path        = "/nerve/services/${name}",
  $check_interval = '2',
  $checks         =  [
    {
      "type"    => "http",
      "uri"     => "/health",
      "timeout" => '0.2',
      "rise"    => '3',
      "fall"    => '2'
    }
  ],
  $target        = "/etc/nerve/conf.d/${name}.json"
) {

  include stdlib

  validate_string($port)
  validate_string($ensure)
  validate_string($host)
  validate_array($zk_hosts)
  validate_string($check_interval)
  validate_array($checks)
  validate_absolute_path($target)

  file { $target:
    ensure  => $ensure,
    owner   => 'root',
    mode    => '0444',
    content => template('nerve/service.json.erb'),
    notify  => Service[nerve],
  }

}
