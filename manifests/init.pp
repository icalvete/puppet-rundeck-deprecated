class rundeck (

  $datasource = $rundeck::params::datasource

) inherits rundeck::params {

  anchor {'rundeck::begin':
    before => Class['rundeck::install']
  }
  class {'rundeck::install':
    require => Anchor['rundeck::begin']
  }
  class {'rundeck::config':
    require => Class['rundeck::install'],
    notify  => Class['rundeck::service']
  }
  class {'rundeck::service':
    require => Class['rundeck::config']
  }
  class {'rundeck::postconfig':
    require => Class['rundeck::service']
  }
  anchor {'rundeck::end':
    require => Class['rundeck::postconfig']
  }
}
