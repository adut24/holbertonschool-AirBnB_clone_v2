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

exec {'mkdir1':
  command => 'mkdir -p /data/web_static/releases/test',
  path    => '/usr/bin/',
}

exec {'mkdir2':
  command => 'mkdir -p /data/web_static/shared/',
  path    => '/usr/bin/',
}

file {'echo':
  ensure  => 'present',
  path    => '/data/web_static/releases/test/index.html',
  content => 'Fake file',
  require => Exec['mkdir1'],
}

exec {'rm':
  command => 'rm -rf /data/web_static/current',
  path    => '/usr/bin/',
  require => [Exec['mkdir1'], Exec['mkdir2']],
}

exec {'ln':
  command => 'ln -s /data/web_static/releases/test /data/web_static/current',
  path    => '/usr/bin/',
  require => Exec['rm'],
}

exec {'chown':
  command => 'chown -R ubuntu:ubuntu /data/',
  path    => '/usr/bin/',
  require => [Exec['mkdir1'], Exec['mkdir2']],
}

file_line {'redirection':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'server_name _;',
  line    => 'location /hbnb_static { alias /data/web_static/current/; autoindex off; }',
  require => Package['nginx'],
}

service {'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
