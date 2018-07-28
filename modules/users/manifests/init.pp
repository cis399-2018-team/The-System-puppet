class users {

    group { 'class':
                ensure => 'present',
                gid => '2003'
    }

    user { 'mhernan':
		ensure => 'present',
		groups => 'class',
		home => '/home/mhernan',
		shell => '/bin/bash'
    }

    file { '/home/mhernan':
    		ensure => directory,
		mode => 444,
		owner => mhernan,
		group => class
	}
}

class keys {
	ssh_authorized_key { 'mhernan':
		ensure => present,
		user => 'mhernan',
		type => 'ssh-rsa',
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDJ/h8vHqc5d7FGeSJNL9e8nNevxC6wzBqT6jcUDR/rhl8Oqu/ohV8GoKC8zR6cR1atEeeNCpCSWg7MFpDZcsKqCAEnY2YJ779HWHzeDYHmLO0Rw1MK26XRY1NIARtC1L6jN02owrfRgj3876R2qX+G3C1XVCNcE44T3UhepdOJDiriXz3KQVa2rdJ7aky9iPNLUfMSDnq+GAjWCabVU+RpHQb1ZQWC1C28nrh+s3qnyBQ7z1APtTm/zT+J97o1JHkCC52t+pOajuBOfPetScF3IZtyIz1Vfcal6GArrUHFw9I/d/pqaUliGWsbVntgojCU66DPHs8AfAQ8WMRtUrY1xh6T3gSMlnHhemkxpp3LSp5xSqEVEzFqN6SFRb1X/w5TRItFZEvczW5qkbbyvF0cv1aEyjcrhPuBOQFWP5/UDez62N27RJY+Dq7TjHS6C962r0ozNtwi5siIP22eHyY+9T87RuBZ98h0uHtpDNp0MRAX6gpJPPRS/oxIxQsTMK03O7EBaJR+1uyrBMioGFqqm5BlTSIIMjSML/Tzq82Uw5Kqa3iDKrDUtxvzkc2rSIKmiHXRfk4A1ySxpjgsjq7HC/6ZygfSFhphDTU6PdQg9nsedv/5gdQBcOxXyXjzTFlX4vxE1DF20YfF4OAd4VzhwwnVkXzn/0GQl4TdL77DIw=='
	}
}

