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
	}

	file {
		"/etc/apache2/sites-available/000-default.conf":
		ensure => present,
		source => "puppet:///modules/apache/000-default.conf",
		mode => 444,
		owner => root, 
		group => root,
		notify => Package["apache2"],
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
