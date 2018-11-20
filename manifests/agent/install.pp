# == Class: check_mk::agent::install
#
# Install check_mk agent.
class check_mk::agent::install (
  $filestore = undef,
  $workspace = $check_mk::agent::workspace,
  $package   = 'check-mk-agent',
) inherits check_mk::agent {
  if $filestore {
    if ! defined(File[$workspace]) {
      file { $workspace:
        ensure => directory,
      }
    }

    # check-mk-agent_1.5.0p7-1_all.deb
    if $package =~ /^(check-mk-(\w*))(-|_)(\d*\.\d*\.\d*p\d*).+\.(\w+)$/ {
      case $5 {
        'deb':     {
          $type = 'dpkg'
        }
        default: {
          $type = $5
        }
      }
      $package_name = $1

      file { "${workspace}/${package}":
        ensure => present,
        source => "${filestore}/${package}",
      }

      package { 'check_mk-agent':
        ensure   => present,
        name     => $package_name,
        provider => $type,
        source   => "${workspace}/${package}",
        require  => File["${workspace}/${package}"],
      }
    } else {
      fail('Package does not match format like check-mk-agent_1.5.0p7-1_all.deb')
    }
  } else {
    package { 'check_mk-agent':
      ensure => present,
      name   => $package,
    }
  }
}
