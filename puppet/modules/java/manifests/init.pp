class java(
        $java_archive = "jdk-8u25-linux-i586.tar.gz",
        $java_home = "/usr/lib/jvm/jdk1.8.0_25",
        $java_folder = "jdk1.8.0_25"
    )
{

    Exec {
        path => [ "/usr/bin", "/bin", "/usr/sbin"]
    }
	
    file { "/tmp/${java_archive}" :
        source => "puppet:///modules/java/${java_archive}",
        owner => vagrant,
        mode => 755
    }
    ->
    file { "/usr/lib/jvm" :
        owner => vagrant,
		ensure => directory
    }
    ->
    exec { "extract jdk" :
        creates => $java_home,
        cwd => "/tmp",
        command => "tar xfv ${java_archive} -C /usr/lib/jvm/"
    }
    ->
    exec { "install javac" :
        command => "update-alternatives --install /bin/javac javac ${java_home}/bin/javac 1"
    }
    ->
    exec { "install java" :
        command => "update-alternatives --install /bin/java java ${java_home}/bin/java 1"
    }
    ->
    exec { "set javac" : 
        command => "update-alternatives --set javac ${java_home}/bin/javac"
    }
    ->
    exec { "set java" :
        command => "update-alternatives --set java ${java_home}/bin/java"
    }
    ->
    file { "/etc/profile.d/java.sh" :
        content => " export JAVA_HOME=${java_home} \n export PATH=\$PATH:\$JAVA_HOME/bin \n "
    }

}
