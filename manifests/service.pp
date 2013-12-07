class rundeck::service {

  service{ $rundeck::params::service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}

