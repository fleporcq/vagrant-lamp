class php::install {

  # package install list
  $packages = [
    "php5",
    "php5-cli",
    "php5-mysql",
    "php5-gd",
    "php5-mcrypt",
    "libapache2-mod-php5"
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  augeas { 'set-php-ini-values':
    context => '/files/etc/php5/apache2/php.ini',
    changes => [
      'set PHP/error_reporting "E_ALL | E_STRICT"',
      'set PHP/display_errors On',
      'set PHP/display_startup_errors On',
      'set PHP/html_errors On',
      'set Date/date.timezone Europe/Paris',
    ],
    require => Package['php5'],
    notify  => Service['apache2'],
  }
}
