
class nginx {
  # install nginx

  case $::osfamily {
    'redhat': {
      $package_name = 'nginx'
      $file_owner = 'root'
      $file_group = 'root'
      $document_root =  '/var/www'
      $config_directory = '/etc/nginx'
      $server_block_directory =  '/etc/nginx/conf.d'
      $logs_directory = '/var/log/nginx'
      $service_name = 'nginx'
      $user_service_runs_as =  'nginx'
    }
    'debian': {
      $package_name = 'nginx'
      $file_owner = 'root'
      $file_group = 'root'
      $document_root =  '/var/www'
      $config_directory = '/etc/nginx'
      $server_block_directory =  '/etc/nginx/conf.d'
      $logs_directory = '/var/log/nginx'
      $service_name = 'nginx'
      $user_service_runs_as =  'www-data'
    }
    'windows': {
      $package_name = 'nginx-service'
      $file_owner = 'Administrator'
      $file_group = 'Administrators'
      $document_root = 'C:/ProgramData/nginx/html'
      $config_directory = 'C:/ProgramData/nginx/conf'
      $server_block_directory = 'C:/ProgramData/nginx/conf.d'
      $logs_directory = 'C:/ProgramData/nginx/logs'
      $service_name = 'nginx'
      $user_service_runs_as = 'nobody'
    }
    default: {
      fail("${operatingsystem} not supported")
    }
  }

  # set some defaults for the files
  File {
    owner => $file_owner,
    group => $file_group,
    mode  => '0644',
  }

  package { $package_name:
    ensure => installed,
  }

  file { [
    $document_root,
    $config_directory,
    $server_block_directory,
    $logs_directory
  ]:
    ensure => directory,
    owner  => $file_owner,
    group  => $file_group
  }


  file { "${config_directory}/nginx.conf":
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
  }

  nginx::vhost { "_": document_root => "${document_root}/_" }

  service { $service_name:
    ensure => running,
    enable => true,
  }
}
