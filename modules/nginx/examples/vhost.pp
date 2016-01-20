
include nginx

nginx::vhost { "smokevhost1": document_root => "/var/www/smokevhost1", }
nginx::vhost { "smokevhost2": document_root => "/var/www/smokevhost2", }
nginx::vhost { "smokevhost3": document_root => "/var/www/smokevhost3", }
nginx::vhost { "smokevhost4": document_root => "/var/www/smokevhost4", }
nginx::vhost { "smokevhost5": document_root => "/var/www/smokevhost5", }

