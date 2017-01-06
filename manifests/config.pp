# == Class: gitolite3::config
#
# Gitolite RC configuration parameters
class gitolite3::config (
  Pattern['^\d+']   $umask                  = '0077',
  String            $git_config_keys        = '',

  Pattern['\d']     $log_extra              = '1',
  Optional[String]  $log_dest               = undef,

  Optional[Boolean] $writer_can_update_desc = undef,
  Optional[String]  $shell_users_list       = undef,

  Hash              $roles                  = {
    'READERS' => '1',
    'WRITERS' => '1',
  },

  Optional[String]  $site_info              = undef,
  Optional[String]  $hostname               = undef,
  Optional[String]  $local_code             = undef,

  # Repo aliasing support
  Optional[Hash]    $repo_aliases           = undef,
  Optional[String]  $repo_aliases_warning   = undef,
  Optional[Hash]    $repo_aliases_pfx_maps  = undef,

  # Triggers
  Optional[Array]   $trigger_input          = undef,
  Optional[Array]   $trigger_access_1       = undef,
  Optional[Array]   $trigger_access_2       = undef,
  Optional[Array]   $trigger_pre_git        = undef,
  Optional[Array]   $trigger_post_git       = undef,
  Optional[Array]   $trigger_pre_create     = undef,
  Optional[Array]   $trigger_post_create    = undef,
  Optional[Array]   $trigger_post_compile   = undef,

  # Enable, with the default options listed
  Array             $enable         = [
    'help',
    'desc',
    'info',
    'perms',
    'writable',
    'ssh-authkeys',
    'git-config',
    'daemon',
    'gitweb',
  ],

  # Override unsafe pattern setting if you like
  Optional[String]  $unsafe_patt            = undef,

) inherits gitolite3 {

  file { "${gitolite3::homedir}/.gitolite.rc":
    ensure  => file,
    content => template("${module_name}/gitolite3.rc.erb"),
    owner   => $gitolite3::username,
    group   => $gitolite3::groupname,
    require => Exec['gitolite3-setup'],
  }
}

