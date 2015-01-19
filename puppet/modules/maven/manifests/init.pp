class maven(
        $maven_archive = "apache-maven-3.2.5-bin.tar.gz",
        $maven_home_dir = "/usr/local/apache-maven",
        $maven_home = "/usr/local/apache-maven/apache-maven-3.2.5"
    )
{

    include java
    
    Exec {
        path => [ "/usr/bin", "/bin", "/usr/sbin"]
    }

    file { "/tmp/${maven_archive}" :
        source => "puppet:///modules/maven/${maven_archive}",
        owner => vagrant,
        mode => 755
    }
    ->
    file { "${maven_home_dir}" :
        ensure => directory
    }
    ->
    exec { "extract archive" :
        creates => $maven_home,
        cwd => "/tmp",
        command => "tar xfv ${maven_archive} -C ${maven_home_dir}"
    }
    ->
    file { "/etc/profile.d/maven.sh" :
        content => " export M2_HOME=${maven_home} \n export M2=${maven_home}/bin \n export MAVEN_OPTS=\"-Xms256m -Xmx512m\" \n export PATH=\$M2:\$PATH \n "
    }
  
}
