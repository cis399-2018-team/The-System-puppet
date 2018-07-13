node ip-10-0-7-236 {
	cron{ "puppet-update":
		command => "cd /etc/puppet && git pull -q origin master",
		user => root,
		minute =>"*/5"
	}
}

node ip-10-0-7-8 {
}

node ip-10-0-7-108 {
}
