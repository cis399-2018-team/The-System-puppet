class The-System {
	package {
		"python3": ensure => installed,
	}

	package {
		"python3-pip": ensure => installed,
	}

	file { 
		"/var/www/the-system-app": 
		ensure => directory, 
		recurse => true, 
		purge => true,
		source => "puppet:///modules/The-System/the-system-app/", 
		mode => 444,
		owner => www-data,
		group => www-data
	}

	exec {
		'install_py_packages':
		cwd => '/var/www/the-system-app',
		command => 'pip3 install -r requirements.txt',
		subscribe => File["/var/www/the-system-app/requirements.txt"],
		refresh => true
	}

	file {
		"/etc/systemd/system/the-system.service"
		ensure => present,
		source => "puppet:///modules/The-System/the-system.service",
		mode => 444,
		owner => root,
		group => root,
	}

	service {
		"the-system":
			enable => true,
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			require => File["/etc/systemd/the-system.service"],
			subscribe => File["/var/www/the-system-app/the-system.py"] 
	} 
}
