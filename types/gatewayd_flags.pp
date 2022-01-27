# Matches systemd gatewayd options in `man systemd-journal-gatewayd`
type Systemd_Journal_Remote::Gatewayd_Flags = Struct[
  {
    Optional['cert']         => Variant[Stdlib::Unixpath],
    Optional['key']          => Variant[Stdlib::Unixpath],
    Optional['trust']        => Variant[Stdlib::Unixpath,Enum['all']],
    Optional['system']       => Variant[Boolean],
    Optional['user']         => Variant[Boolean],
    Optional['D']            => Variant[Stdlib::Unixpath],
    Optional['directory']    => Variant[Stdlib::Unixpath],
    Optional['file']         => Variant[String],
  }
]
