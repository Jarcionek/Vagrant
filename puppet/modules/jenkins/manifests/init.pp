class jenkins() {

    file { "/usr/lib/jenkins/jenkins.war" :
        require => File["/usr/lib/jenkins/"],
        source => "puppet:///modules/jenkins/jenkins.war",
        owner => vagrant,
		ensure => file
    }
    
    file { "/usr/lib/jenkins/" :
        ensure => directory
    }

}
