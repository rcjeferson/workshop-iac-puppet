$packages = ['git', 'nginx']

package { $packages:
  ensure => installed,
}

file { '/app':
  ensure => directory,
  owner  => 'nginx',
  group  => 'nginx',
  mode   => '0750',
  notify => Exec['clone'],
}

exec { 'clone':
  command     => '/usr/bin/git clone https://github.com/rcjeferson/workshop-iac-app.git /app',
  unless      => '/usr/bin/test -e /app/index.html',
  refreshonly => true,
}

Package[$packages]
-> File['/app']
-> Exec['clone']

augeas { 'nginx_root' :
  context => '/files/etc/nginx/nginx.conf/http/server',
  changes => 'set root /app',
}

service { 'nginx':
  ensure => running,
  enable => true,
}

Package[$packages]
-> Augeas['nginx_root']
~> Service['nginx']

file { '/etc/cron.d/app':
  ensure  => file,
  content => "* * * * * root cd /app && git pull\n",
}

exec { 'firewall_nginx':
  command => '/usr/bin/firewall-cmd --zone public --add-port=80/tcp --permanent',
  unless  => '/usr/bin/firewall-cmd --list-all | /usr/bin/grep "80" > /dev/null',
  notify  => Exec['firewall_reload'],
}

exec { 'firewall_reload':
  command     => '/usr/bin/firewall-cmd --reload',
  refreshonly => true,
}
