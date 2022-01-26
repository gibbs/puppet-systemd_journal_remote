# @summary
#   This class configures the [Upload] section of journal-upload.conf
#
# @api private
#
class systemd_journal_remote::upload::config {
  assert_private()

  $systemd_journal_remote::upload::options.each |$option, $value| {
    ini_setting { $option:
      path    => '/etc/systemd/journal-upload.conf',
      section => 'Upload',
      setting => $option,
      value   => $value,
      notify  => Service[$systemd_journal_remote::upload::service_name],
    }
  }

  # @fixme A better approach to managing argument variations
  $options = $systemd_journal_remote::upload::command_flags.filter |$key, $value| {
    $key in ['merge', 'system', 'user']
  }

  $flags = $systemd_journal_remote::upload::command_flags.filter |$key, $value| {
    $key in ['D', 'u']
  }

  $arguments = $systemd_journal_remote::upload::command_flags.filter |$key, $value| {
    ($key in ['D', 'merge', 'system', 'u', 'user'] == false)
  }

  # Formatted arguments
  $command_arguments = [
    $arguments.join_keys_to_values('=').prefix('--').join(' '),
    $flags.join_keys_to_values('=').prefix('-').join(' '),
    $options.keys.prefix('--').join(' ')
  ].join(' ')

  systemd::dropin_file { 'systemd_journal_remote-upload_dropin':
    filename => 'service-override.conf',
    unit     => "${systemd_journal_remote::upload::service_name}.service",
    content  => epp("${module_name}/upload.service-override.epp", {
      'path'      => $systemd_journal_remote::upload::command_path,
      'arguments' => $command_arguments,
    }),
    notify   => Service[$systemd_journal_remote::upload::service_name],
  }
}
