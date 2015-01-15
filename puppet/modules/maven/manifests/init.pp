class maven() {

  include java

  notify { "log-1" :
    message => "starting maven installation - it may take a while"
  }
  ->
  package { "maven" :
    ensure => latest,
    loglevel => info
  }
  ->
  notify { "log-2" :
    message => "maven installation finished"
  }

}
