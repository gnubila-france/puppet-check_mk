# == Class: check_mk::agent
#
# Manage check_mk agent
#
# === Parameters
#
# @param ensure   [present,absent]  Ensure, default = 'present'
# @manage_package [Boolean]         Wether to manage agent package install
# @manage_config  [Boolean]         Wether to manage agent config
# @manage_service [Boolean]         Wether to manage agent service
# @mrpe_checks   [Hash]             mrpe checks to add to mrpe.cfg
#
class check_mk::agent (
  $ensure             = present,
  $manage_package     = $check_mk::params::agent_manage_package,
  $manage_config      = $check_mk::params::agent_manage_config,
  $manage_service     = $check_mk::params::agent_manage_service,
  $config_dir   = $check_mk::params::agent_config_dir,
  $filestore          = undef,
  $host_tags          = undef,
  $ip_whitelist       = undef,
  $port               = '6556',
  $server_dir         = '/usr/bin',
  $use_cache          = false,
  $user               = 'root',
  $version            = undef,
  $workspace          = '/root/check_mk',
  $package            = undef,
  $mrpe_checks        = {},
) inherits check_mk::params {
  validate_hash($mrpe_checks)
  include ::check_mk::agent::install
  include ::check_mk::agent::config
  include ::check_mk::agent::service
  Class['check_mk::agent::install'] ->
  Class['check_mk::agent::config']
  @@check_mk::host { $::fqdn:
    host_tags => $host_tags,
  }
  create_resources('check_mk::agent::mrpe', $mrpe_checks)
}
