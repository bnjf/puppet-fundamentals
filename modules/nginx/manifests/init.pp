
class nginx {
  # install nginx
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
    enable => true,
  }
}
