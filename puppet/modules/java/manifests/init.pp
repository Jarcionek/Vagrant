class java(
        $java_archive = "jdk-8u25-linux-i586.tar.gz",
        $java_home = "/usr/lib/jvm/jdk1.8.0_25",
        $java_folder = "jdk1.8.0_25"
    )
{

    Exec {
        path => [ "/usr/bin", "/bin", "/usr/sbin"]
    }
	
    file { "/etc/profile.d/java.sh" :
        content => " export JAVA_HOME=${java_home} \n export PATH=\$PATH:\$JAVA_HOME/bin \n "
    }

    exec { "set java" :
        require => Exec["install java"],
        command => "update-alternatives --set java ${java_home}/bin/java"
    }

    exec { "set javac" : 
        require => Exec["install javac"],
        command => "update-alternatives --set javac ${java_home}/bin/javac"
    }
	
	
    exec { "install java" :
        require => Exec["move jdk"],
        command => "update-alternatives --install /bin/java java ${java_home}/bin/java 1"
    }

    exec { "install javac" :
        require => Exec["move jdk"],
        command => "update-alternatives --install /bin/javac javac ${java_home}/bin/javac 1"
    }

    exec { "move jdk" :
        creates => $java_home,
        require => File["/usr/lib/jvm"],
        cwd => "/tmp",
        command => "mv ${java_folder} /usr/lib/jvm/"
    }

    file { "/usr/lib/jvm" :
        require => Exec["extract jdk"],
        owner => vagrant,
		ensure => directory
    }

    exec { "extract jdk" :
        creates => $java_home,
        cwd => "/tmp",
        command => "tar xfv ${java_archive}",
        require => File["/tmp/${java_archive}"]
    }
	
    file { "/tmp/${java_archive}" :
        source => "puppet:///modules/java/${java_archive}",
        owner => vagrant,
        mode => 755
    }

}
