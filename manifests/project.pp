define rundeck::project (

  $project_name   = $title,
  $resources_user = undef,
  $resources_pass = undef,
  $resources_url  = undef,
  $nodes          = []

  ){

  file{["${rundeck::params::project_dir}/projects/${project_name}",
        "${rundeck::params::project_dir}/projects/${project_name}/etc",
        "${rundeck::params::project_dir}/projects/${project_name}/var",
        ]:
          ensure  => directory,
          mode    => '0644',
          owner   => $rundeck::params::user,
          group   => $rundeck::params::group,
          before  => File["${project_name}-project.properties"]
  }

  file{"${project_name}-project.properties":
    ensure  => present,
    path    => "${rundeck::params::project_dir}/projects/${project_name}/etc/project.properties",
    mode    => '0644',
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    content => template("${module_name}/project.properties.erb")
  }

  file{"${project_name}-resources.yaml":
    ensure  => present,
    path    => "${rundeck::params::project_dir}/projects/${project_name}/etc/resources.yaml",
    mode    => '0644',
    owner   => $rundeck::params::user,
    group   => $rundeck::params::group,
    content => template("${module_name}/resources.yaml.erb")
  }

  $acl_project_name = downcase($project_name)
  file{"${acl_project_name}-aclpolicy":
    path      => "$rundeck::params::config_dir/${acl_project_name}.aclpolicy",
    content   => template("${module_name}/aclpolicy.erb"),
    owner     => $rundeck::params::user,
    group     => $rundeck::params::group,
    mode      => '0644'
  }
}
