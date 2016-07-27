class check_mk::params {

  # common variables
  $checkmk_service = 'omd'
  $package = 'omd-0.56'
  $filestore = undef
  $host_groups= undef
  $site = 'monitoring'
  $workspace = '/root/check_mk'

  $agent_manage_package = true
  $agent_manage_config = true
  $agent_manage_service = true

  # OS specific variables
  case $::osfamily {
    'RedHat': {
      $httpd_service = 'httpd'
      $agent_config_dir = '/etc/check-mk-agent/'
    }
    'Debian': {
      $httpd_service = 'apache2'
      $agent_config_dir = '/etc/check_mk/'
    }
    default: {
      $httpd_service = 'httpd'
      $agent_config_dir = '/etc/check-mk-agent/'
    }
  }
}
