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
# @param manage_package
#   Manage the package installation
#
# @param manage_service
#   Manage the systemd-journal-remote service
#
# @param package_name
#   The systemd-journal-remote package name to use
#
# @param package_ensure
#   Ensure the systemd-journal-remote package state
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
class systemd_journal_remote (
  Stdlib::Absolutepath $command_path                        = '/usr/lib/systemd/systemd-journal-remote',
  Systemd_Journal_Remote::Remote_Flags $command_flags       = {},
  Boolean $manage_output                                    = false,
  Boolean $manage_package                                   = true,
  Boolean $manage_service                                   = true,
  String $package_name                                      = 'systemd-journal-remote',
  Enum['latest', 'absent', 'present'] $package_ensure       = present,
  Boolean $service_enable                                   = true,
  Stdlib::Ensure::Service $service_ensure                   = running,
  String $service_name                                      = 'systemd-journal-remote',
  Optional[Systemd_Journal_Remote::Remote_Options] $options = {},
) {
  contain systemd_journal_remote::install
  contain systemd_journal_remote::config
  contain systemd_journal_remote::service
  contain systemd_journal_remote::upload

  Class['systemd_journal_remote::install']
  -> Class['systemd_journal_remote::config']
  -> Class['systemd_journal_remote::service']
}
