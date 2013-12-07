class rundeck::config {

  file{'rundeck-config.properties':
    ensure  => present,
    path    => "${rundeck::params::config_dir}/rundeck-config.properties",
    content => template("${module_name}/rundeck-config.properties.erb"),
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    mode    => '0644'
  }

  file{'realm.properties':
    ensure  => present,
    path    => "${rundeck::params::config_dir}/realm.properties",
    content => template("${module_name}/realm.properties.erb"),
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    mode    => '0644'
  }

  file{'framework.properties':
    ensure  => present,
    path    => "${rundeck::params::config_dir}/framework.properties",
    content => template("${module_name}/framework.properties.erb"),
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    mode    => '0644'
  }

  file{'quartz.properties':
    path    => "$rundeck::params::home_dir/exp/webapp/WEB-INF/classes/quartz.properties",
    content => "org.quartz.threadPool.threadCount = ${rundeck::params::threads}",
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    mode    => '0644'
  }

  file{'rundeck-jobs-directory':
    ensure  => present,
    source  => "puppet:///modules/${module_name}/jobs",
    path    => "${rundeck::params::project_dir}/jobs",
    recurse => true,
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    mode    => '0755',
  }

  file{"${rundeck::params::home_dir}/.ssh":
    ensure  => directory,
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
  }

  file{'rundeck_id_rsa.pub':
    path    => "${rundeck::params::home_dir}/.ssh/id_rsa.pub",
    source  => 'puppet:///modules/sp/rundeck_ssh_keys/id_rsa.pub',
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    mode    => '0644',
    require => File["$rundeck::params::home_dir/.ssh"]
  }

  file{'rundeck_id_rsa':
    path    => "${rundeck::params::home_dir}/.ssh/id_rsa",
    source  => 'puppet:///modules/sp/rundeck_ssh_keys/id_rsa',
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    mode    => '0600',
    require => File["$rundeck::params::home_dir/.ssh"]
  }

  rundeck::project{'sp':}

  Sshkey <<| tag == 'rundeck' |>>
}

