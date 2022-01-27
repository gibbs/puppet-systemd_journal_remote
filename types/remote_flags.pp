# Matches systemd remote options in `man systemd-journal-remote`
type Systemd_Journal_Remote::Remote_Flags = Struct[
  {
    Optional['url']          => Variant[Stdlib::HTTPUrl,Stdlib::HTTPSUrl],
    Optional['getter']       => Variant[String],
    Optional['listen-raw']   => Variant[String],
    Optional['listen-http']  => Variant[String,Integer[-3, -1]],
    Optional['listen-https'] => Variant[String,Integer[-3, -1]],
    Optional['key']          => Variant[Stdlib::Unixpath],
    Optional['cert']         => Variant[Stdlib::Unixpath],
    Optional['trust']        => Variant[Stdlib::Unixpath,Enum['all']],
    Optional['gnutls-log']   => Variant[String],
    Optional['output']       => Variant[Stdlib::Unixpath],
    Optional['gnutls-log']   => Variant[String],
    Optional['split-mode']   => Variant[Enum['none','host']],
    Optional['compress']     => Variant[Enum['yes','no']],
    Optional['seal']         => Variant[Enum['yes','no']],
  }
]
