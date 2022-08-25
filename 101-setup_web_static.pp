# Set up Nginx
exec {'update':
  command => 'apt-get update',
  path    => '/usr/bin/env/',
}

-> package {'nginx':
  ensure  => 'present',
  name    => 'nginx',
  require => Exec['update'],
}

-> exec {'mkdir1':
  command => 'mkdir -p /data/web_static/releases/test',
  path    => '/usr/bin/env/',
}

-> exec {'mkdir2':
  command => 'mkdir -p /data/web_static/shared/',
  path    => '/usr/bin/env/',
}

-> file {'echo':
  ensure  => 'present',
  path    => '/data/web_static/releases/test/index.html',
  content => 'Fake file',
  require => Exec['mkdir1'],
}

-> exec {'rm':
  command => 'rm -rf /data/web_static/current',
  path    => '/usr/bin/env/',
  require => [Exec['mkdir1'], Exec['mkdir2']],
}

-> exec {'ln':
  command => 'ln -s /data/web_static/releases/test /data/web_static/current',
  path    => '/usr/bin/env/',
  require => Exec['rm'],
}

-> exec {'chown':
  command => 'chown -R vagrant:vagrant /data/',
  path    => '/usr/bin/env/',
  require => [Exec['mkdir1'], Exec['mkdir2']],
}

-> file_line {'redirection':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'server_name _;',
  line    => 'location /hbnb_static { alias /data/web_static/current/; autoindex off; }',
  require => Package['nginx'],
}

-> service {'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
