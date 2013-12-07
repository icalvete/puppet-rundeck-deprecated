class rundeck::install {

  realize Package[$rundeck::params::pre_package]

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      common::down_resource {'rundeck_get_package':
        scheme   => $rundeck::params::repo_scheme,
        domain   => $rundeck::params::repo_domain,
        port     => $rundeck::params::repo_port,
        user     => $rundeck::params::repo_user,
        pass     => $rundeck::params::repo_pass,
        path     => $rundeck::params::repo_path,
        resource => $rundeck::params::repo_resource,
      }

      exec {'rundeck_install_package':
        cwd     => '/tmp/',
        command => "/usr/bin/dpkg -i ${rundeck::params::repo_resource}",
        require => Common::Down_resource['rundeck_get_package'],
        before  => Package[$rundeck::params::package],
        unless  => '/usr/bin/dpkg -l rundeck | grep ii'
      }
    }
    /^(CentOS|RedHat)$/: {

      exec{ 'rundeck_install_repo':
        command => '/bin/rpm -Uvh http://repo.rundeck.org/latest.rpm',
        unless  => '/usr/bin/test -f /etc/yum.repos.d/rundeck.repo'
      }
    }
  }

  package {$rundeck::params::package:
    ensure  => present,
    require => Package[$rundeck::params::pre_package]
  }
}
