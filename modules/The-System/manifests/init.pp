class The-System{
  package {
    "apache2": ensure => installed;
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
    group => root,
    require => Package("apache2")
  }
  service {
  }
}
