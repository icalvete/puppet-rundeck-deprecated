#puppet-rundeck

Puppet manifest to install and configure Rundeck

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-rundeck.png)](http://travis-ci.org/icalvete/puppet-rundeck)

See [Rundeck site](http://rundeck.org/)

##Requires:

* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/icalvete/puppet-common 

##Example:

```
node 'ubuntu01.smartpurposes.net' inherits test_defaults {
  include roles::puppet_agent
  include rundeck

  rundeck::project{'sp':
    nodes   => ['ubuntu02', 'ubuntu03'],
    require => Class['rundeck::config'],
    notify  => Class['rundeck::service']
  }
}

node 'ubuntu02.smartpurposes.net' inherits test_defaults {
  include roles::puppet_agent
  include rundeck::client
}

node 'ubuntu03.smartpurposes.net' inherits test_defaults {
  include roles::puppet_agent
  include rundeck::client
}
```

##Authors:

Israel Calvete Talavera <icalvete@gmail.com>
