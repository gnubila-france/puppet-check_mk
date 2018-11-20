# == Class: check_mk::agent
#
# Configures and install the check_mk agent.
class check_mk::agent (
  Optional[Stdlib::Filesource] $filestore         = undef,
  Optional[Array]              $host_tags         = undef,
  Stdlib::Absolutepath         $workspace         = '/root/check_mk',
  Optional[String]             $package           = undef,
  Hash                         $mrpe_checks       = {},
  Optional[String]             $encryption_secret = undef,
  Stdlib::Absolutepath         $config_dir = $check_mk::agent::params::config_dir,
) inherits check_mk::agent::params {
  include check_mk::agent::install
  include check_mk::agent::config
  Class['check_mk::agent::install'] -> Class['check_mk::agent::config']

  @@check_mk::host { $::fqdn:
    host_tags => $host_tags,
  }

  create_resources('check_mk::agent::mrpe', $mrpe_checks)
}
