# == Class: check_mk::install
#
# Installs check_mk through a deb or rpm file
class check_mk::install (
  String $site,
  Stdlib::Absolutepath $workspace,
  Optional[Stdlib::Filesource] $filestore = undef,
  String $package = undef,
) {
  if $filestore {
    if ! defined(File[$workspace]) {
      file { $workspace:
        ensure => directory,
      }
    }
    file { "${workspace}/${package}":
      ensure  => present,
      source  => "${filestore}/${package}",
      require => File[$workspace],
    }

    # check-mk-raw-1.5.0p7_0.stretch_amd64.deb
    if $package =~ /^(check-mk-(\w*))-(\d*\.\d*\.\d*p\d*).+\.(deb)$/ {
      case $4 {
        'deb':     { 
          $type = 'apt'
          $package_name = "${workspace}/${package}"
        }
        'default': { 
          $type = $4
          $package_name = $1
        }
      }

      package { $package_name:
        ensure   => installed,
        provider => $type,
        source   => "${workspace}/${package}",
        require  => File["${workspace}/${package}"],
      }
    } else {
      fail('Package does not match format check-mk-raw-1.5.0p7_0.stretch_amd64.deb')
    }
  }
  else {
    $package_name = $package
    package { $package_name:
      ensure => installed,
    }
  }
  $etc_dir = "/omd/sites/${site}/etc"
  exec { 'omd-create-site':
    command => "/usr/bin/omd create ${site}",
    creates => $etc_dir,
    require => Package[$package_name],
  }
}
