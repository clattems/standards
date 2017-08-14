class standards {
  package { 'sharutils':
    ensure => installed,
  }

  package { 'sysstat':
    ensure => installed,
  }
  file { '/etc/profile.d/ps1.sh':
    ensure => file,
    mode => '0644',
    source => 'puppet:///modules/standards/ps1.sh',
  }
}
