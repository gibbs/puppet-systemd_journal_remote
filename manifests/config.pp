# @summary
#   This class configures the [Remote] section of journal-remote.conf
#
# @api private
#
class systemd_journal_remote::config {
  assert_private()

  $systemd_journal_remote::options.each |$option, $value| {
    ini_setting { $option:
      path    => '/etc/systemd/journal-remote.conf',
      section => 'Remote',
      setting => $option,
      value   => $value,
      notify  => Service[$systemd_journal_remote::service_name],
    }
  }

  systemd::dropin_file { 'service-override.conf':
    unit    => "${systemd_journal_remote::service_name}.service",
    content => epp("${module_name}/systemd-journal-remote.service-override.epp", {
      'command_path'  => $systemd_journal_remote::command_path,
      'command_flags' => $systemd_journal_remote::command_flags,
    }),
    notify  => Service[$systemd_journal_remote::service_name],
  }
}
