class The-System{
  package {
    "python3": ensure => installed;
    "pip3": ensure => installed;
  }

  file {
    "/var/www/the-system-app":
    ensure => directory,
    recurse => true,
    source => "puppet:///modules/The-System/the-system-app/",
    mode => 444,
    owner => root,
    group => root
  }

  file {
    ensure => directory,
    recurse => true,
    source => "puppet:///modules/The-System/the-system.service",
    mode => 444,
    owner => root,
    group => root
  }

  service {
    "system-service":
    enable => true,
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => File["/var/www/the-system-app"]
    subscribe => File["/var/www/the-system-app"]
  }
}
