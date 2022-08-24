# Set up Nginx
exec {'update':
  command => 'apt-get update',
  path    => '/usr/bin/',
}

package {'nginx':
  ensure  => 'present',
  name    => 'nginx',
  require => Exec['update'],
}

exec {'create directories n°1':
  command => 'mkdir -p /data/web_static/releases/test',
  path    => '/usr/bin/',
}

exec {'create directories n°2':
  command => 'mkdir -p /data/web_static/shared/',
  path    => '/usr/bin/',
}

file {'Create a file':
  ensure  => 'present',
  path    => '/data/web_static/releases/test/index.html',
  content => 'Fake file',
}

exec {'remove symbolic link':
  command => 'rm -rf /data/web_static/current',
  path    => '/usr/bin/',
}

exec {'create a new symbolic link':
  command => 'ln -sT /data/web_static/releases/test /data/web_static/current',
  path    => '/usr/bin/',
}

exec {'change owner of directories':
  command => 'chown -R "ubuntu":"ubuntu" /data/',
  path    => '/usr/bin/',
}

file_line {'add redirection':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'server_name _;',
  line   => 'location /hbnb_static { alias /data/web_static/current/; autoindex off; }',
}

service {'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
