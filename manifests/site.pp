node ip-10-0-7-236 {
	cron{ "puppet-update":
		command => "cd /etc/puppet && git pull -q origin master",
		user => root,
		minute =>"*/5"
		
	}
	include sshd
}

node ip-10-0-7-8 {
	include sshd
	include apache
	include users
	include mongo
	include The-System
}


node ip-10-0-7-108 {  
	include sshd 
	include apache
	include users
	include mongo
	include The-System
}
