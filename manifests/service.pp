# @summary
#   This class manages the systemd-journal-remote service
#
# @api private
#
class systemd_journal_remote::service {
  assert_private()

  if $systemd_journal_remote::manage_output {
    file { '/var/log/journal/':
      ensure => directory,
      owner  => 0,
      group  => 'systemd-journal',
      mode   => '2755',
    }

    file { '/var/log/journal/remote/':
      ensure => directory,
      owner  => 0,
      group  => 'systemd-journal-remote',
      mode   => '2755',
    }
  }

  if $systemd_journal_remote::manage_service {
    service { $systemd_journal_remote::service_name:
      ensure => $systemd_journal_remote::service_ensure,
      name   => $systemd_journal_remote::service_name,
      enable => $systemd_journal_remote::service_enable,
    }
  }
}
