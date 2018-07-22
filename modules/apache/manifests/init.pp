class apache {
	package {
		"apache2": ensure => installed;
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
				File["/etc/ssh/sshd_config"] ],
		# changes to configuration cause service restart
		subscribe  => File["/etc/ssh/sshd_config"]
	}
}
