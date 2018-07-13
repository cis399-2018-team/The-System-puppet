class sshd {
	package {
		"sshd":ensure => installed;
	}
	file { "/etc/ssh/sshd_config":
		source	=> 
			puppet:///modeuls/sshd/files/$hostname/sshd.conf
			puppet:///modules/sshd/sshd.conf",
		mode	=> 444,
		owner 	=> root,
		group => root,
		require => Package["sshd"]
	}
	
	service { "sshd":
	
	enable	=> true,
	ensure	=> running,
	hasstatus	=> true,
	hasrestart	=> true,
	require	=> [ Package["sshd"],
			File["/etc/sshd.conf]
	subscribe	=> File["/etc/sshd.conf"]
}
