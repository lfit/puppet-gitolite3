class gitolite3 (
  Boolean $manage_package = $gitolite3::params::manage_package,
  String  $package_name   = $gitolite3::params::package_name,
  Enum['present', 'absent', 'installed', 'latest']
          $package_ensure = $gitolite3::params::package_ensure,

  Pattern['^\/'] $homedir     = $gitolite3::params::homedir,
  String         $username    = $gitolite3::params::username,
  String         $groupname   = $gitolite3::params::groupname,
  Pattern['^\/'] $install_cmd = $gitolite3::params::install_cmd,

  Optional[String]  $admin_key_content   = undef,
  Optional[String]  $admin_key_source    = undef,
) inherits gitolite3::params {

  if $admin_key_source and $admin_key_content {
    fail 'Parameters `admin_key_source` and `admin_key_content` are mutually exclusive'
  }

  if ! ($admin_key_source or $admin_key_content) {
    fail 'Must specify either `admin_key_source` or `admin_key_content`'
  }

  anchor { "${module_name}::begin": } ->
  class { "${module_name}::install": } ->
  class { "${module_name}::config": } ->
  anchor { "${module_name}::end": }
}
