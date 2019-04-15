# == Class: check_mk::agent::params
#
class check_mk::agent::params {
    case $::osfamily {
    'RedHat': {
      $config_dir = '/etc/check-mk-agent'
    }
    'Debian': {
      $config_dir = '/etc/check_mk'
    }
    default: {
      fail("OS familly ${::osfamily} is not managed!")
    }
  }
}
