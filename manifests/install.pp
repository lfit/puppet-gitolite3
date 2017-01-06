# == Class: gitolite3::install
class gitolite3::install inherits gitolite3 {

  if $gitolite3::manage_package {
    ensure_packages([
      $gitolite3::package_name,
    ],
    { ensure => $gitolite3::package_ensure }
    )
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
