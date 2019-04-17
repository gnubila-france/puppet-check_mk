# == Class: check_mk::service
#
# Configures the check mk service
class check_mk::service (
  String $checkmk_service,
  String $httpd_service,
) {
  if ! defined(Service[$httpd_service]) {
    service { $httpd_service:
      ensure => 'running',
      enable => true,
    }
  }
  if ! defined(Service[xinetd]) {
    service { 'xinetd':
      ensure => 'running',
      enable => true,
    }
  }
  service { $checkmk_service:
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
  }
}
