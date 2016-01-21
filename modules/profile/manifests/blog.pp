class profile::blog {

  #include profile::webserver
  class { 'apache': }
  class { 'apache::mod::php': }
  package { 'php-mysql':
    ensure => present, 
  }

  #include profile::database_server
  class { '::mysql::server': }

  # ...
  user { 'wordpress':
    ensure => present,
  }
  class { 'wordpress':
    wp_owner    => 'wordpress',
    wp_group    => 'wordpress',
    db_user     => 'wordpress',
    db_password => 'wordpress',
    #install_dir => '/var/www/wordpress',
  }
}
