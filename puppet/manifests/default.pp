# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}
exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

class { 'apache2::install': }
class { 'php::install': }
class { 'composer::install': }
class { 'mysql::install': }
class { 'phpmyadmin::install': }
class { 'git::install': }
