class mongo {
	package {
		"mongodb": ensure => installed
	}

	service {
		"mongod":
		enable => true,
		ensure => running,
		hasstatus => true,
		hasrestart => true
	}
}
