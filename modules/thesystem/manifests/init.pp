class thesystem {
	package {
		"python3": ensure => present,
	}

	package {
		"python3-pip": ensure => present,
	}

	file { 
		"/var/www/the-system-app": 
		ensure => directory, 
		recurse => true, 
		purge => true,
		source => "puppet:///modules/thesystem/the-system-app/", 
		mode => 444,
		owner => www-data,
		group => www-data
	}

	file {
		"/etc/systemd/system/the-system.service":
		ensure => present,
		source => "puppet:///modules/thesystem/the-system.service",
		mode => 444,
		owner => root,
		group => root,
	}

	service {
		"the-system":
			enable => true,
			ensure => running,
			require => File["/etc/systemd/the-system.service"],
			subscribe => File["/var/www/the-system-app/the-system.py"] 
	} 

	service {
		'apache2':
			ensure => running,
			enable => true,
			require => Package['apache2'],
	}
}
