# Matches systemd remote options
type Systemd_journal_remote::RemoteOptions = Struct[
  {
    Optional['Seal']                   => Variant[Enum['yes','no'],Systemd::JournaldSettings::Ensure],
    Optional['SplitMode']              => Variant[Enum['host','none'],Systemd::JournaldSettings::Ensure],
    Optional['ServerKeyFile']          => Variant[Stdlib::Absolutepath,Systemd::JournaldSettings::Ensure],
    Optional['ServerCertificateFile']  => Variant[Stdlib::Absolutepath,Systemd::JournaldSettings::Ensure],
    Optional['TrustedCertificateFile'] => Variant[Stdlib::Absolutepath,Enum['all'],Systemd::JournaldSettings::Ensure],
  }
]
