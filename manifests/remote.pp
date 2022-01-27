# @summary
#   This module manages and configures the systemd journal remote package
#
# @api public
#
# @param command_path
#   The systemd-journal-remote systemd command path
#
# @param command_flags
#   The systemd-journal-remote ExecStart command flags to use in service file
#
# @param manage_output
#   Manage the default output paths (/var/log/journal/remote/)
#
# @param manage_service
#   Manage the systemd-journal-remote service
#
# @param service_ensure
#   Ensure the systemd-journal-remote state
#
# @param service_name
#   The systemd-journal-remote service name
#
# @param options
#   Config hash to configure the [Remote] options in journal-remote.conf
#
# @author Dan Gibbs <dev@dangibbs.co.uk>
#
class systemd_journal_remote::remote (
  Stdlib::Absolutepath $command_path                        = '/usr/lib/systemd/systemd-journal-remote',
  Systemd_Journal_Remote::Remote_Flags $command_flags       = {},
  Boolean $manage_output                                    = false,
  Boolean $manage_service                                   = true,
  Boolean $service_enable                                   = true,
  Stdlib::Ensure::Service $service_ensure                   = running,
  String $service_name                                      = 'systemd-journal-remote',
  Optional[Systemd_Journal_Remote::Remote_Options] $options = {},
) {
  require systemd_journal_remote

  contain systemd_journal_remote::remote::config
  contain systemd_journal_remote::remote::service

  Class['systemd_journal_remote::remote::config']
  -> Class['systemd_journal_remote::remote::service']
}
