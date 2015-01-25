class jenkins::nginx::packages {
  exec { '/bin/su - root -mc "wget -q -O - http://nginx.org/keys/nginx_signing.key | apt-key add -"': }

  file { '/etc/apt/sources.list.d/nginx.list':
    ensure => present,
    source => 'puppet:///modules/jenkins/etc/apt/sources.list.d/nginx.list',
    mode => 644,
    require => Exec['/bin/su - root -mc "wget -q -O - http://nginx.org/keys/nginx_signing.key | apt-key add -"']
  }

  exec { 'apt-get update':
    path => ['/usr/bin'],
    require => File['/etc/apt/sources.list.d/nginx.list']
  }

  package {[
      'nginx'
    ]:
    ensure => present,
    require => Exec['apt-get update']
  }
}