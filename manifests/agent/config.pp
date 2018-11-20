# == Class: check_mk::agent::config
#
# Configure check_mk agent.
#
# === Parameters
#
#
class check_mk::agent::config (
  Optional[String] $encryption_secret = $check_mk::agent::encryption_secret,
  Stdlib::Absolutepath $config_dir = $check_mk::agent::config_dir,
) inherits check_mk::agent {
  if $encryption_secret {
    file {'encryption_config':
      ensure  => file,
      path    => "${config_dir}/encryption.cfg",
      content => template('check_mk/agent/encryption.cfg.erb'),
    }
  }
}
