# == Class: gitolite3::params
#
# This is a container class with default parameters for gitolite classes.
class gitolite3::params {
  $manage_package = true
  $package_name   = 'gitolite3'
  $package_ensure = 'installed'
  # If $repodir_path is defined, it will be set up as the canonical location
  # for gitolite-managed git repositories, and symlinked into
  # $GITOLITE_HOME/repositories. Note, that you *may* run into troubles
  # with hooks, paths, alternates, etc, if you choose to go down this route,
  # but simple installations should be safe.
  # XXX: You cannot change this after gitolite has been set up and expect
  # things to work, as the repository would need to be manually moved first.
  $repodir_path = undef
  $repodir_mode = undef
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
