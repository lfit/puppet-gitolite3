# == Class: gitolite3::params
#
# This is a container class with default parameters for gitolite classes.
class gitolite3::params {
  $manage_package = true
  $package_name   = 'gitolite3'
  $package_ensure = 'installed'
  $homedir        = '/var/lib/gitolite3'
  $username       = 'gitolite3'
  $groupname      = 'gitolite3'
  $install_cmd    = '/usr/bin/gitolite3 setup -pk'
}
