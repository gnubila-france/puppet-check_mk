#
# Add entry to the mrpe.cfg file
#
### Parameters
#
### command
#
# The command to run
#
### Example
#
# ```
# check_mk::agent::mrpe { 'Test':
#   command => '/bin/true'
# }
# ```
#

define check_mk::agent::mrpe (
  String $command,
  Stdlib::Absolutepath $config_dir = $check_mk::agent::config_dir,
) {
  $mrpe_config_file = "${config_dir}/mrpe.cfg"

  if ! defined(Concat[$mrpe_config_file]) {
    concat { $mrpe_config_file:
      ensure => 'present',
    }
  }

  concat::fragment { "${name}-mrpe-check":
    target  => $mrpe_config_file,
    content => "${name} ${command}\n",
  }
}
