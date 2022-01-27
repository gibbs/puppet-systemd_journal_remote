# @summary
#   This class manages and configures the systemd journal gatewayd service
#
# @api public
#
# @param command_path
#   The systemd-journal-gatewayd systemd command path
#
# @param command_flags
#   The systemd-journal-gatewayd ExecStart command flags to use in service file
#
# @param manage_service
#   Manage the systemd-journal-gatewayd service
#
# @param service_enable
#   Enable the systemd-journal-gatewayd service
#
# @param service_name
#   The systemd-journal-gatewayd service name
#
# @author Dan Gibbs <dev@dangibbs.co.uk>
#
class systemd_journal_remote::gatewayd (
  Stdlib::Absolutepath $command_path                        = '/usr/lib/systemd/systemd-journal-gatewayd',
  Systemd_Journal_Remote::Gatewayd_Flags $command_flags     = {},
  Boolean $manage_service                                   = true,
  Boolean $service_enable                                   = true,
  Stdlib::Ensure::Service $service_ensure                   = running,
  String $service_name                                      = 'systemd-journal-gatewayd',
) {
  require systemd_journal_remote

  contain systemd_journal_remote::gatewayd::config
  contain systemd_journal_remote::gatewayd::service

  Class['systemd_journal_remote::gatewayd::config']
  -> Class['systemd_journal_remote::gatewayd::service']
}
