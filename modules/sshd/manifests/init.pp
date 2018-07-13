class sshd {
	package {
		"sshd":ensure => installed;
	}
	file { "/etc/ssh/sshd_config":
		source	=> [
			"puppet:///modules/sshd/$hostname/sshd.conf",
			"puppet:///modules/sshd/sshd.conf",
		],
		mode	=> 444,
		owner 	=> root,
		group => root,
		require => Package["sshd"],
	}
	
	service { "sshd":
	
	enable	=> true,
	ensure	=> running,
	hasstatus	=> true,
	hasrestart	=> true,
	require	=> [ Package["sshd"],
			File["/etc/sshd.conf]],
	subscribe	=> File["/etc/sshd.conf"],
	}
	
	ssh_authorized_key { "quinn_key":
		user => "ubuntu",
		key => "aaaab3nzac1yc2eaaAADAQABAAABAQCL9F71YgYpfFYpFfeOqLlRlBai6X9niYCMmBOmSqIVnL81NF9b0XfNkSMgv4/6/ab3TXm9GVTKYY3cSr5m/K0ufNS4DZ3e7U9gyEiYutbXBohYXZ/ngh98WGOf2wS2Y2s5+XLrI+vauLA/QHjtLesh6QPZXxWRt63io9+ZdUHeWkMphGLvDyzd8QwM9mRJmNGxb2dP34ACTgGYgCGKzsLgEJ7ADbUC30GRhvPNqX3w+DXXGF/RmP7kknCrkesjhH7m+IQeFF1Uppaexai5EOiNQks5G6Bmkfbb8l+SRpCvcXxDSrK+42uhQkt7tbgy7j1YbjpBbtaE0pViHIV+Mi6V"

		"mhernan_key":
		user => "ubuntu",
		key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCBz/FWaJSh15HkEcACB6Wh3jwT7EnCGr6pYFDuuqtXkHl2z4nIMHtT79azu/6jEwAC5664YBe8LLlVYUfgox4bCnlMbCbd+CXkUVviRNr3J/CH2vyK80zX9kLI0C3A6IJjzfweNOC/BRjvUHK0+GZlfdspEEinyEbD0UvAm1KFYaxYSNT23cFSwM422ojDlsEI/KWgcKTmtvmsEbJUcTHjx4nWCP69OEvZuH392wbZISyhEXnbINxnfmEho13fmk/qOO0MRA/LT9zT7OPUJjsd3X0qrabLu+W6PZbqysRe/ZGIiMC+YJXoUn/7QNbg9V4faBI0PTIMefW1qMtiHqM7"
	}
}
