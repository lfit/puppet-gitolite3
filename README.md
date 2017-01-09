# gitolite3

[![Build Status](https://travis-ci.org/mricon/puppet-gitolite3.svg?branch=master)]
(https://travis-ci.org/mricon/puppet-gitolite3)

"Puppet module to manage Gitolite installation and configuration")

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with gitolite](#setup)
    * [Beginning with gitolite](#beginning-with-gitolite)
4. [Reference](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors](#contributors)

## Overview
Puppet module to manage Gitolite3 installation and configuration.

## Module Description
This module installs and configures [Gitolite](http://gitolite.com/) version 3.
It assumes you will be using a package provided by your distribution and
currently does not manage username/homedir creation, etc.

## Setup

### Beginning with gitolite3
The quickest way to be up and running using the gitolite3 module is to copy your public SSH key in the files folder of this module.
So, you can use this syntax:

```puppet
class { 'gitolite3':
  admin_key_content => 'ssh-rsa AAAA...',
}
```

Please see the "params" and "config" classes for configurable settings. It's
expected that this will be used with hiera, so the quickest way to configure
it for your environment is to add it to your Puppetfile:

```
mod 'mricon-gitolite3'
```

And then set up your hiera:

```yaml
gitolite3::admin_key_content: 'ssh-rsa AAAA...'
gitolite3::config::umask: '0022'
gitolite3::config::log_dest: 'syslog,normal'
```

## Reference

### gitolite3

#### `manage_package`

Whether to manage package installation or not.

Default: `true`

#### `package_name`

Name of the package to install. NOTE: you will need to make sure your
repositories provide this package, as this module makes no assumptions about
how you install EPEL.

Default: `gitolite3`

#### `package_ensure`

What do you want to do with the package.

Default: `installed`

#### `repodir_path`

If defined, it will be set up as the canonical location for gitolite-managed
git repositories, and symlinked into $GL_HOME/repositories.  Note, that you
*may* run into troubles with hooks, paths, alternates, etc, if you choose to
go down this route, but simple installations should be safe.

NOTE: You cannot change this after gitolite has been set up and expect
things to work, as the repository would need to be manually moved first.

Default: `undef`

#### `repodir_mode`

The mode to set on the repodir_path defined above.

Default: `0755`

#### `homedir`

Where does gitolite get installed. Note, that we don't manage this location,
just use it for installing other files. If it isn't `/var/lib/gitolite3`, you
should set this to whatever the package you are installing provides.

Default: `/var/lib/gitolite3`

#### `username`

Which user should own the config file(s)? You should set this to whatever user
your package/other scripts used to set up gitolite. Changing it here will not
have the desired effect.

Default: `gitolite3`

#### `groupname`

Which group should own the config file(s)? You should set this to whatever
group your package/other scripts used to set up gitolite. Changing it here
will not have the desired effect.

Default: `gitolite3`

#### `install_cmd`

Which command should run to do the initial gitolite setup. It will be followed
by the key you provide as part of the setup.

Default: `/bin/gitolite setup -pk`

#### `admin_key_content`

Contents of the SSH public key that should become the admin user after
gitolite install. This should be the full key, including `ssh-rsa` and any
comments at the end.

Default: undefined

#### `admin_key_source`

Alternatively, a source file for the public key should be listed in a format
that is understood by puppet (e.g. `puppet:///modules/foo/bar.pub`).

NOTE: Either `admin_key_content` or `admin_key_source` MUST be defined if
you're setting up gitolite from scratch (i.e. don't already have an existing
gitolite installation and just want to manage the .gitolite.rc file).

Default: undefined

### gitolite3::config

These variables define configuration parameters for the main .gitolite.rc
file. Please see http://gitolite.com/gitolite/rc.html for details.

#### `umask`

Controls the UMASK variable.

Default: `'0077'`

#### `git_config_keys`

Controls the GIT_CONFIG_KEYS variable.

Default: `''`

#### `log_extra`

Controls the LOG_EXTRA variable.

Default: `'1'`

#### `log_dest`

Controls the LOG_DEST variable.

Default: `undef`


#### `writer_can_update_desc`

Controls the WRITER_CAN_UPDATE_DESC variable.

Default: `undef`

#### `shell_users_list`

See http://gitolite.com/gitolite/sts.html#the-shell_users_list.

Default: `undef`

#### `roles`

Hash of ROLES definitions.

Default: `{ 'READERS'=>'1', 'WRITERS'=>'1', }`

#### `site_info`

Controls the SITE_INFO variable.

Default: `undef`

#### `hostname`

Controls the HOSTNAME variable.

Default: `undef`

#### `local_code`

Controls the LOCAL_CODE variable. Carefully read
http://gitolite.com/gitolite/non-core.html#ncloc before changing it.

Default: `undef`

#### `repo_aliases`
#### `repo_aliases_warning`
#### `repo_aliases_pfx_maps`

See https://github.com/sitaramc/gitolite/blob/master/src/lib/Gitolite/Triggers/Alias.pm

Defaults: `undef`

#### `trigger_input`
#### `trigger_access_1`
#### `trigger_access_2`
#### `trigger_pre_git`
#### `trigger_post_git`
#### `trigger_pre_create`
#### `trigger_post_create`
#### `trigger_post_compile`

See http://gitolite.com/gitolite/triggers.html. All values are arrays.

Defaults: `undef`

#### `enable`

Array of features to enable.

Default: `[ 'help', 'desc', 'info', 'perms', 'writable', 'ssh-authkeys', 'git-config', 'daemon', 'gitweb' ]`

#### `unsafe_patt`

Controls the UNSFAFE_PATT variable.

Default: `undef`

## Limitations

RedHat and CentOS 7 are the only ones tested on. Also, we are currently
letting the official packages manage user and homedir creation, so this module
will not handle that bit for you.

## Development

Originally developed by [Echoes Technologies](https://echoes.fr)

Pretty much entirely rewritten by Konstantin Ryabitsev for LF IT use to only
support CentOS 7, puppet 4 and Gitolite 3.

