# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "java8" do |java8|
    java8.vm.box = "hashicorp/precise32"
    java8.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "java.pp"
      puppet.module_path = "puppet/modules"
    end
  end
  
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "hashicorp/precise32"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 55555
    jenkins.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "java-and-jenkins.pp"
      puppet.module_path = "puppet/modules"
    end
    jenkins.vm.provision "shell", run: "always" do |s|
      s.inline = "java -jar /usr/lib/jenkins/jenkins.war &"
    end
  end
  
end
