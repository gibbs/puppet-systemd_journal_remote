# Matches systemd remote options in `man journal-remote.conf`
type Systemd_Journal_Remote::Remote_Options = Struct[
  {
    Optional['Seal']                   => Variant[Enum['yes','no']],
    Optional['SplitMode']              => Variant[Enum['host','none']],
    Optional['ServerKeyFile']          => Variant[Stdlib::Absolutepath],
    Optional['ServerCertificateFile']  => Variant[Stdlib::Absolutepath],
    Optional['TrustedCertificateFile'] => Variant[Stdlib::Absolutepath,Enum['all']],
  }
]
