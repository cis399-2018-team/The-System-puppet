class apache {
	package {
		"apache2": ensure => present,
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
		notify => Package["apache2"],
		require => Package["apache2"]

	}

	file {
		"/etc/apache2/sites-available/000-default.conf":
		ensure => present,
		source => "puppet:///modules/apache/000-default.conf",
		mode => 444,
		owner => root, 
		group => root,
		require => Package["apache2"],
		notify => Package["apache2"],
	}

	# Enable mods
	file {
		'/etc/apache2/mods-enabled/proxy.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/proxy.conf':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy.conf',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/proxy_ajp.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy_ajp.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/proxy_http.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy_http.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/rewrite.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/rewrite.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/deflate.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/deflate.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/deflate.conf':
		ensure => 'link',
		target => '/etc/apache2/mods-available/deflate.conf',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/headers.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/headers.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/proxy_balancer.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy_balancer.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/proxy_balancer.conf':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy_balancer.conf',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/proxy_connect.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy_connect.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	file {
		'/etc/apache2/mods-enabled/proxy_html.conf':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy_html.conf',
		notify => Service['apache2'],
		require => Package['apache2'],
	}
	
	file {
		'/etc/apache2/mods-enabled/proxy_html.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/proxy_html.load',
		notify => Service['apache2'],
		require => Package['apache2'],
	}

	service {
		"apache2":
		# automatically start at boot time
		enable => true,
		# restart service if it is not running
		ensure => running,
		# package and configuration must be present for service
		require    => [ Package["apache2"],
				File["/etc/apache2/apache2.conf"] ],
		# changes to configuration cause service restart
		subscribe  => [
				File["/etc/apache2/sites-available/000-default.conf"], 
				File["/etc/apache2/apache2.conf"]]
	}
}
