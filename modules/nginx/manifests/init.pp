
class nginx {
  # install nginx

  # set some defaults for the files
  File {
    owner => 'root',
    group => 'root',
    mode  => 420,
  }

  package { 'nginx':
    ensure => installed,
  }

  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/index.html':
    source => "puppet:///modules/nginx/index.html",
  }

  file { '/etc/nginx/nginx.conf':
    source => "puppet:///modules/nginx/nginx.conf",
    notify => Service['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    source => "puppet:///modules/nginx/default.conf",
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
