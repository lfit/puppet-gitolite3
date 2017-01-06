# == Class: gitolite3::params
#
# This is a container class with default parameters for gitolite classes.
class gitolite3::params {
  $manage_package = true
  $package_name   = 'gitolite3'
  $package_ensure = 'installed'
  # These parameters are for config file location/ownership purposes,
  # and not for controlling where your gitolite gets installed in the
  # first place (it is expected that the gitolite3 package will do that.
  # If you install gitolite via some other way, it's up to you to handle
  # user creation, homedir management, etc.
  $homedir        = '/var/lib/gitolite3'
  $username       = 'gitolite3'
  $groupname      = 'gitolite3'
  # This command will be followed by the admin key.
  $install_cmd    = '/bin/gitolite setup -pk'
}
