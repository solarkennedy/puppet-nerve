#nerve
[![Build Status](https://travis-ci.org/solarkennedy/puppet-nerve.png?branch=master)](https://travis-ci.org/solarkennedy/puppet-nerve)

##Overview

This puppet module installs and configures
[Nerve](https://github.com/airbnb/nerve) as part of Airbnb's
[SmartStack](http://nerds.airbnb.com/smartstack-service-discovery-cloud/).

It allows you to dynamically register services in Zookeeper. See also
[Puppet-Synapse](https://github.com/solarkennedy/puppet-synapse) to configure
the [Synapse](https://github.com/airbnb/synapse) side of SmartStack: a local
HAproxy that allows your services to find other services registered in
zookeeper, by only needing to connect to localhost.

##Installation

    puppet module install KyleAnderson/nerve
    # Or librarian-puppet, r10k, whatever

##Usage

Default settings ensure present, and use system packages:

    include nerve

Use gem install:
 
```puppet
class { 'nerve': 
  package_provider => 'gem'
}
```

Use system packages, latest, but not running:

```puppet
class { 'nerve':
  package_ensure => 'latest',
  service_ensure => 'stopped',
}
```

See init.pp or params.pp for more fields you can override. You can do things like:
 - instance\_id (defaults to $::fqdn)
 - config\_file (defaults to /etc/nerve/nerve.conf.json)
 - config\_dir  (defaults to /etc/nerve/conf.d/)
 - etc.

## Registering Services

These are the defaults (Everything optional except for port):

```puppet
nerve::register { 'service1':
  port           => '3000',
  target         => '/etc/nerve/conf.d/service1.json',
  host           => '127.0.0.1',
  zk_hosts       => ["localhost:2181"],
  zk_path        => "/nerve/services/service1",
  check_interval => '2',
  checks         => [
    {
      'type' => 'http',
      'uri'  => '/health',
      'timeout' => '0.2',
      'rise'    => '3',
      'fall'    => '2'
    }
  ],
}
```

`zk_hosts` is an array of strings. Checks is an array of hashes. 

##Limitations

The OS support assumes that rubygem-nerve is available or `gem install nerve`
is functioning. (depending on the provider you specify)

##Development
Open an [issue](https://github.com/solarkennedy/puppet-nerve/issues) or 
[fork](https://github.com/solarkennedy/puppet-nerve/fork) and open a 
[Pull Request](https://github.com/solarkennedy/puppet-nerve/pulls)
