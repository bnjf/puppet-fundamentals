
class nginx (
  $document_root = hiera("nginx::root", $nginx::params::document_root),
  $package_name = $nginx::params::package_name,
  $file_owner = $nginx::params::file_owner,
  $file_group = $nginx::params::file_group,
  $config_directory = $nginx::params::config_directory,
  $server_block_directory = $nginx::params::server_block_directory,
  $logs_directory = $nginx::params::logs_directory,
  $service_name = $nginx::params::service_name,
  $user_service_runs_as = $nginx::params::user_service_runs_as
) inherits nginx::params {
  # install nginx

  notify { "got root=$root document_root=$document_root": }

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
