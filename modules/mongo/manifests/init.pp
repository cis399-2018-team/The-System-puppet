class mongo {
	package {
		"mongodb": ensure => installed
	}

	service {
		"mongod":
		enable => true,
		ensure => running,
		hasstatus => running,
		hasrestart => true
	}
}
