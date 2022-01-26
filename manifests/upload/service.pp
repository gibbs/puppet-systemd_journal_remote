# @summary
#   This class manages the systemd-journal-upload service
#
# @api private
#
class systemd_journal_remote::upload::service {
  assert_private()

  if $systemd_journal_remote::upload::manage_service {
    service { $systemd_journal_remote::upload::service_name:
      ensure => $systemd_journal_remote::upload::service_ensure,
      name   => $systemd_journal_remote::upload::service_name,
      enable => $systemd_journal_remote::upload::service_enable,
    }
  }
}
