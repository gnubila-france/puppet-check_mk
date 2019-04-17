# == Class: check_mk::host
#
# Resource to create a check_mk host
define check_mk::host (
  Optional[String] $target = undef,
  Optional[Array]  $host_tags = [],
) {
  $host = $title
  if size($host_tags) > 0 {
    $taglist = join($host_tags,'|')
    $entry = "${host}|${taglist}"
  }
  else {
    $entry = $host
  }
  concat::fragment { "check_mk-${host}":
    target  => $target,
    content => "  '${entry}',\n",
    order   => 11,
  }
}
