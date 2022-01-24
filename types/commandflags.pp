# Matches systemd remote options
type Systemd_journal_remote::CommandFlags = Struct[
  {
    Optional['url']          => Variant[Stdlib::HTTPUrl,Stdlib::HTTPSUrl,Systemd::JournaldSettings::Ensure],
    Optional['getter']       => Variant[String,Systemd::JournaldSettings::Ensure],
    Optional['listen-raw']   => Variant[String,Systemd::JournaldSettings::Ensure],
    Optional['listen-http']  => Variant[String,Integer[-3, -1],Systemd::JournaldSettings::Ensure],
    Optional['listen-https'] => Variant[String,Integer[-3, -1],Systemd::JournaldSettings::Ensure],
    Optional['key']          => Variant[Stdlib::Unixpath,Systemd::JournaldSettings::Ensure],
    Optional['cert']         => Variant[Stdlib::Unixpath,Systemd::JournaldSettings::Ensure],
    Optional['trust']        => Variant[Stdlib::Unixpath,Enum['all'],Systemd::JournaldSettings::Ensure],
    Optional['gnutls-log']   => Variant[String,Systemd::JournaldSettings::Ensure],
    Optional['output']       => Variant[Stdlib::Unixpath,Systemd::JournaldSettings::Ensure],
    Optional['gnutls-log']   => Variant[String,Systemd::JournaldSettings::Ensure],
    Optional['split-mode']   => Variant[Enum['none','host'],Systemd::JournaldSettings::Ensure],
    Optional['compress']     => Variant[Enum['yes','no'],Systemd::JournaldSettings::Ensure],
    Optional['seal']         => Variant[Enum['yes','no'],Systemd::JournaldSettings::Ensure],
  }
]
