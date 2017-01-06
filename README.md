# gitolite

[![Build Status](https://travis-ci.org/mricon/puppet-gitolite3.svg?branch=master)]
(https://travis-ci.org/mricon/puppet-gitolite3)

"Puppet module to manage Gitolite installation and configuration")

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with gitolite](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with gitolite](#beginning-with-gitolite)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Contributors](#contributors)

## Overview

Puppet module to manage Gitolite3 installation and configuration.

## Module Description

This module installs and configures [Gitolite](http://gitolite.com/) version 3.

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

For full list of configuration parameters, see `manifests/config.pp`.

## Limitations

RedHat and CentOS 7 are the only ones tested on. Also, we are currently
letting the official packages manage user and homedir creation, so this module
will not handle that bit for you.

## Development

Originally developed by [Echoes Technologies](https://echoes.fr)

Pretty much entirely rewritten by Konstantin Ryabitsev for LF IT use to only
support CentOS 7, puppet 4 and Gitolite 3.

