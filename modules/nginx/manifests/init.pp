
class nginx (
  $root = false
) inherits nginx::params {
  # install nginx

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

  # nuke the default config
  file { "${server_block_directory}/default.conf":
    ensure => absent,
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
