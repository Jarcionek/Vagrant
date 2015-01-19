class nexus(
        $nexus_archive = "nexus-2.11.1-01-bundle.tar.gz",
        $nexus_home = "/usr/local/nexus-2.11.1-01"
    )
{

    require java
    
    Exec {
        path => [ "/usr/bin", "/bin", "/usr/sbin"]
    }

    file { "/tmp/${nexus_archive}" :
        source => "puppet:///modules/nexus/${nexus_archive}",
        owner => vagrant,
        mode => 755
    }
    ->
    exec { "extract archive" :
        creates => $nexus_home,
        cwd => "/tmp",
        command => "tar xfv ${nexus_archive} -C /usr/local/"
    }
    ->
    exec { "set nexus owner" :
        command => "chown vagrant -R ${nexus_home} && chown vagrant -R /usr/local/sonatype-work"
    }
    ->
    file { "/etc/profile.d/nexus.sh" :
        content => " export NEXUS_HOME=${nexus_home} \n "
    }
    ->
    exec { "start nexus" :
        command => "${nexus_home}/bin/nexus start",
        user => "vagrant"
    }
    
  
}
