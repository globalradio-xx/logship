class logship {

  file { "/etc/logship.conf":
    source  => "puppet://$servername/logship/logship.conf",
    ensure  => present,
    owner   => "root",
    group   => "wheel",
    mode    => "644",
  }

  # you probably only need the explict package "libconfig-tiny-perl"
  package { "libconfig-tiny-perl": ensure => installed }
  package { "openssh-client":      ensure => installed }
  package { "rsync":               ensure => installed }
  
  file { "/usr/local/sbin/logship":
    ensure  => present,
    require => [ File["/etc/logship.conf"],
                 Package["libconfig-tiny-perl"],
		 Package["openssh-client"],
		 Package["rsync"] ],
    source  => "puppet://$servername/logship/logship",
    owner   => "root",
    group   => "wheel",
    mode    => "755",
  }

  file { "/etc/cron.d/logship":
    require => File["/usr/local/sbin/logship"],
    source  => "puppet://$servername/logship/logship.cron",
    owner   => "root",
    group   => "wheel",
    mode    => "644",
  }
}
