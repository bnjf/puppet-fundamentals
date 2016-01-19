
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

}
