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

	# Enable mods
	file {
		'/var/www/etc/apache2/mods-enabled/proxy.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/proxy.conf':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy.conf',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/proxy_ajp.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy_ajp.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/proxy_http.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy_http.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/rewrite.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/rewrite.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/deflate.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/deflate.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/deflate.conf':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/deflate.conf',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/headers.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/headers.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/proxy_balancer.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy_balancer.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/proxy_balancer.conf':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy_balancer.conf',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/proxy_connect.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy_connect.load',
	}

	file {
		'/var/www/etc/apache2/mods-enabled/proxy_html.conf':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy_html.conf',
	}
	
	file {
		'/var/www/etc/apache2/mods-enabled/proxy_html.load':
		ensure => 'link',
		target => '/var/www/etc/apache2/mods-available/proxy_html.load',
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
}
