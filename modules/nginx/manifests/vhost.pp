
define nginx::vhost(
  $document_root
) {

  notify { "creating vhost ${title}, serving from $document_root": }

  $server_name = $title;

  # notify should bounce nginx
  file { "/etc/nginx/conf.d/${title}.conf":
    ensure  => file,
    content => template('nginx/vhost.conf.erb'),
    notify  => Service['nginx'],
  }

  file { $document_root: ensure => directory, }
                                                  
  file { "${document_root}/index.html":          
    ensure  => file,                             
    content => template('nginx/index.html.erb'), 
  }                                              

  # stick in a dummy host entry
  host { $title:
    ensure => present,
    ip     => '0.0.0.0',
  }

}
