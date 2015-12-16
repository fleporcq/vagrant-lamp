class apache2::install {

  File {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  # install apache
  package { "apache2":
    ensure => present,
    require => Exec["apt-get update"],
  }->
  service { "apache2":
    ensure => running,
  }


  # Disable default site
  exec { "a2dissite 000-default" :
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  file { '/var/www/html':
    ensure  => absent,
    recurse => true,
    force => true,
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
  file { '/etc/apache2/mods-enabled/rewrite.load':
    ensure => link,
    target => '/etc/apache2/mods-available/rewrite.load',
  }


  # Source https://raw.github.com/Intracto/Puppet/master/apache2/manifests/init.pp

  # Change user
  exec { "ApacheUserChange" :
    command => "sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars",
    onlyif  => "grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  # Change group
  exec { "ApacheGroupChange" :
    command => "sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars",
    onlyif  => "grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  exec { "apache_lockfile_permissions" :
    command => "chown -R vagrant:vagrant /var/lock/apache2",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  #links from /vagrant shared folder
  file {"/var/www":
    ensure => "link",
    target => "/vagrant/www",
    require => Package["apache2"],
    notify => Service["apache2"],
    replace => yes,
    force => true,
  }

  file {"/etc/apache2/sites-enabled":
    ensure => "link",
    target => "/vagrant/vhosts",
    require => Package["apache2"],
    notify => Service["apache2"],
    replace => yes,
    force => true,
  }

}
