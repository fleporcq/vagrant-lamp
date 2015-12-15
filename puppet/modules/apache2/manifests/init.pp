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

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure  => absent,
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
}
