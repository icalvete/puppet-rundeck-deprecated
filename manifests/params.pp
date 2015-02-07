class rundeck::params {

  $datasource    = 'h2'
  $db_host       = hiera('rundeck_db_host')
  $db            = hiera('rundeck_db')
  $db_user       = hiera('rundeck_db_user')
  $db_pass       = hiera('rundeck_db_pass')

  $repo_scheme   = 'http'
  $repo_domain   = 'download.rundeck.org'
  $repo_port     = false
  $repo_user     = false
  $repo_pass     = false
  $repo_path     = 'deb'
  $repo_resource = 'rundeck-2.4.1-1-GA.deb'

  $admin_user    = hiera('rundeck_admin_user')
  $admin_pass    = hiera('rundeck_admin_pass')

  $package       = 'rundeck'
  $service       = 'rundeckd'

  $threads       = '20'
  $home_dir      = '/var/lib/rundeck'
  $config_dir    = '/etc/rundeck'
  $project_dir   = '/var/rundeck'
  $user          = 'rundeck'
  $group         = 'rundeck'

  $exportedjobs  = "${project_dir}/jobs"

  $ssh_public_key = hiera('rundeck_ssh_public_key')
  $ssh_key        = hiera('rundeck_ssh_key')

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $pre_package = 'openjdk-7-jre'
    }
    /^(CentOS|RedHat)$/: {
      $pre_package = 'java-1.6.0-openjdk'
    }
  }
}
