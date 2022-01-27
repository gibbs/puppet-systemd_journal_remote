# @summary
#   This class installs the systemd-journal-remote package
#
# @api private
#
class systemd_journal_remote::install {
  assert_private()

  if $systemd_journal_remote::manage_package {
    package { $systemd_journal_remote::package_name:
      ensure => $systemd_journal_remote::package_ensure,
    }
  }
}
