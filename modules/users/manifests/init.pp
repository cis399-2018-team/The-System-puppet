class users {

    group { 'class':
                ensure => 'present',
                gid => '2003'
    }
}
