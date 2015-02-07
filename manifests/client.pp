class rundeck::client inherits rundeck::params {

  include sp::params

  user {$rundeck::params::user:
    ensure => present,
    home   => $rundeck::params::home_dir
  }

  file {$rundeck::params::home_dir:
    ensure  => directory,
    owner   => $rundeck::params::user,
    require => User[$rundeck::params::user]
  }

  ssh_authorized_key{'rundeck_public_key':
    ensure => present,
    type   => rsa,
    user   => $rundeck::params::user,
    key    => $rundeck::params::ssh_public_key
  }

  $host_aliases = [ $ipaddress, $hostname]
  @@sshkey { $fqdn:
    ensure       => present,
    host_aliases => $host_aliases,
    type         => 'rsa',
    key          => $sshrsakey,
    tag          => 'rundeck'
  }

  File[$rundeck::params::home_dir] -> Ssh_authorized_key['rundeck_public_key']
}
