# @summary
#   This class manages the systemd-journal-gatewayd service
#
# @api private
#
class systemd_journal_remote::gatewayd::service (
  $manage_service = $systemd_journal_remote::gatewayd::manage_service,
  $service_enable = $systemd_journal_remote::gatewayd::service_enable,
  $service_ensure = $systemd_journal_remote::gatewayd::service_ensure,
  $service_name   = $systemd_journal_remote::gatewayd::service_name,
) {
  assert_private()

  if $manage_service {
    service { $service_name:
      ensure => $service_ensure,
      name   => $service_name,
      enable => $service_enable,
    }
  }
}
