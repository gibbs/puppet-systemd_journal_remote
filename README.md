# systemd journal remote

[![Build Status](https://github.com/gibbs/puppet-systemd_journal_remote/workflows/CI/badge.svg)](https://github.com/gibbs/puppet-systemd_journal_remote/actions?query=workflow%3ACI)
[![Release](https://github.com/gibbs/puppet-systemd_journal_remote/workflows/Release/badge.svg)](https://github.com/gibbs/puppet-systemd_journal_remote/actions?query=workflow%3ARelease)
[![Apache-2 License](https://img.shields.io/github/license/gibbs/puppet-systemd_journal_remote.svg)](LICENSE)

## Overview

This module installs, configures and manages the **systemd-journal-remote**
systemd service.

## Example Usage

### Default

With no configuration the `systemd-journal-remote` service listens over HTTP
and outputs to `/var/log/journal/remote/` using the default package
configuration:

```puppet
include ::systemd_journal_remote
```

### Configuration

- The `command_flags` parameter is used to manage the unit file command arguments
- The `options` paramter is used to configure `journal-remote.conf` INI settings

Parameter names and their values mirror and are validated against all
arguments and options documented in `man systemd-journal-remote` and
`man journal-remote.conf`.

### Passive Configuration Example

An example passive service to receive journald logs and events.

```puppet
class { '::systemd_journal_remote':
  command_flags => {
    'listen-https' => '0.0.0.0:19532',
    'compress'     => 'yes',
    'output'       => '/var/log/journal/remote/',
  },
  options       => {
    'SplitMode'              => 'host',
    'ServerKeyFile'          => "/etc/puppetlabs/puppet/ssl/private_keys/${trusted['certname']}.pem",
    'ServerCertificateFile'  => "/etc/puppetlabs/puppet/ssl/certs/${trusted['certname']}.pem",
    'TrustedCertificateFile' => '/etc/puppetlabs/puppet/ssl/certs/ca.pem',
  }
}
```

In Hiera:

```yaml
systemd_journal_remote::command_flags:
  listen-https: 0.0.0.0:19532
  compress: 'yes'
  output: /var/log/journal/remote/

systemd_journal_remote::options:
  SplitMode: host
  ServerKeyFile: "/etc/puppetlabs/puppet/ssl/private_keys/%{trusted.certname}.pem"
  ServerCertificateFile: "/etc/puppetlabs/puppet/ssl/certs/%{trusted.certname}.pem"
  TrustedCertificateFile:  /etc/puppetlabs/puppet/ssl/certs/ca.pem
```

### Active Configuration Example

An example active service that requests and pulls data:

```puppet
class { '::systemd_journal_remote':
  command_flags => {
    'url'    => 'https://some.host:19531/',
    'getter' => "'curl \"-HAccept: application/vnd.fdo.journal\" https://some.host:19531/'",
    'output' => '/var/log/journal/remote/',
  },
  options       => {
    'SplitMode' => 'host',
  }
}
```

In Hiera:

```yaml
systemd_journal_remote::command_flags:
  url: https://some.host:19531/
  getter: "'curl \"-HAccept: application/vnd.fdo.journal\" https://some.host:19531/'"
  output: /var/log/journal/remote/

systemd_journal_remote::options:
  SplitMode: host
```
