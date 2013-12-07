class rundeck::postconfig {

  exec {'load-jobs':
    # rd-jobs doesn't admit any fancy *.xml thing, so we have to feed it file by file
    command   => "for a in `ls ${rundeck::params::exportedjobshome}/*.xml`; do /usr/bin/rd-jobs load -f \$a; done",
    provider  => shell,
    #TODO rundeck service doest start listening for connections inmediatelly, it takes some time to boot up
    #TODO the platform before everything is ready (around 29 seconds according to logs) so we have to use
    #TODO  this KLUDGE. For the next SPRINT I should try to find a better way
    tries     => 3,
    try_sleep => 30
  }
}
