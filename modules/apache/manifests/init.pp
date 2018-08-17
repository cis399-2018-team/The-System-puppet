class apache {
	package {
		"apache2": ensure => installed,
	}

	file {
		"/etc/apache2/apache2.conf":
		ensure => present,
		source => [
			"puppet:///modules/apache/$hostname/apache2.conf",
			"puppet:///modules/apache/apache2.conf"],
		mode => 444,
		owner => root,
		group => root,
		# package must be installed before configuration file
		require => Package["apache2"]

	}

	file {
		"/etc/apache2/sites-available/000-default.conf":
		ensure => present,
		source => "puppet:///modules/apache/000-default.conf",
		mode => 444,
		owner => root, 
		group => root,
		require => Package["apache2"]
	}

	service {
		"apache2":
		# automatically start at boot time
		enable => true,
		# restart service if it is not running
		ensure => running,
		# "service smartd status" returns useful service status info
	        hasstatus  => true,
		# "service smartd restart" can restart service
		hasrestart => true,
		# package and configuration must be present for service
		require    => [ Package["apache2"],
				File["/etc/apache2/apache2.conf"] ],
		# changes to configuration cause service restart
		subscribe  => [
				File["/etc/apache2/sites-available/000-default.conf"], 
				File["/etc/apache2/apache2.conf"]]
	}

	exec {
		'enable_mods':
		cwd => '/etc/apache2/mods-enabled/',
		command => 'a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html',
		# Check if mods are already there
		unless => 'test -L proxy_http.load',
		# Tell apache2 to restart
		notify => Service['apache2'],
		require =>  Package["apache2"]
	}
	
}
