# Matches systemd upload options in `man systemd-journal-upload`
type Systemd_Journal_Remote::Upload_Flags = Struct[
  {
    Optional['u']            => Variant[Stdlib::Host,Stdlib::HTTPUrl,Stdlib::HTTPSUrl],
    Optional['url']          => Variant[Stdlib::Host,Stdlib::HTTPUrl,Stdlib::HTTPSUrl],
    Optional['system']       => Variant[Boolean],
    Optional['user']         => Variant[Boolean],
    Optional['merge']        => Variant[Boolean],
    Optional['D']            => Variant[Stdlib::Unixpath],
    Optional['directory']    => Variant[Stdlib::Unixpath],
    Optional['file']         => Variant[String],
    Optional['cursor']       => Variant[String],
    Optional['after-cursor'] => Variant[String],
    Optional['save-state']   => Variant[Stdlib::Unixpath],
    Optional['follow']       => Variant[Boolean],
    Optional['key']          => Variant[Enum['-'],Stdlib::Unixpath],
    Optional['cert']         => Variant[Enum['-'],Stdlib::Unixpath],
    Optional['trust']        => Variant[Enum['-', 'all'],Stdlib::Unixpath],
  }
]
