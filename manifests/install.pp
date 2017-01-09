# == Class: gitolite3::install
#
# Install class for gitolite3
class gitolite3::install inherits gitolite3 {

  if $gitolite3::manage_package {
    ensure_packages([
      $gitolite3::package_name,
    ],
    { ensure => $gitolite3::package_ensure }
    )
  }

  if $gitolite3::repodir_path {
    if $gitolite3::repodir_mode {
      $repodir_mode = $gitolite3::repodir_mode
    } else {
      $repodir_mode = '0755'
    }
    file { 'gitolite3-repo-canonical':
      ensure => directory,
      path   => $gitolite3::repodir_path,
      owner  => $gitolite3::username,
      group  => $gitolite3::groupname,
      mode   => $repodir_mode,
    }
    file { 'gitolite3-repo-symlink':
      ensure  => link,
      path    => "${gitolite3::homedir}/repositories",
      target  => $gitolite3::repodir_path,
      owner   => $gitolite3::username,
      group   => $gitolite3::groupname,
      require => File['gitolite3-repo-canonical'],
      before  => Exec['gitolite3-setup'],
    }
  }

  file { "${gitolite3::homedir}/admin.pub":
    ensure  => file,
    source  => $gitolite3::admin_key_source,
    content => $gitolite3::admin_key_content,
    owner   => $gitolite3::username,
    group   => $gitolite3::groupname,
    mode    => '0400',
  } ->
  exec { 'gitolite3-setup':
    command     => "${gitolite3::install_cmd} admin.pub",
    path        => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
    user        => $gitolite3::username,
    cwd         => $gitolite3::homedir,
    environment => "HOME=${gitolite3::homedir}",
    creates     => "${gitolite3::homedir}/.gitolite/conf/gitolite.conf",
  }
}
