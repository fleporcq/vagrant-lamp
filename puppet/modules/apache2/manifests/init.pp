class apache2::install {

  # install apache
  package { "apache2":
    ensure => present,
    require => Exec["apt-get update"]
  }


  service { "apache2":
    ensure => running,
    require => Package["apache2"]
  }

  # the httpd.conf change the user/group that apache uses to run its process
  file { '/etc/apache2/conf-available/user.conf':
    source  => '/vagrant/files/etc/apache2/user.conf',
  }
  file { '/etc/apache2/conf-enabled/user.conf':
    ensure => link,
    target => '/etc/apache2/conf-available/user.conf',
  }
  
  #mod_rewrite
  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package["apache2"]
  }
}
