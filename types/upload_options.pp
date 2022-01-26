# Matches systemd upload options
type Systemd_Journal_Remote::Upload_Options = Struct[
  {
    Optional['URL']                    => Variant[Stdlib::HTTPUrl, Stdlib::HTTPSUrl],
    Optional['ServerKeyFile']          => Variant[Stdlib::Absolutepath],
    Optional['ServerCertificateFile']  => Variant[Stdlib::Absolutepath],
    Optional['TrustedCertificateFile'] => Variant[Stdlib::Absolutepath],
    Optional['NetworkTimeoutSec']      => Variant[Integer,String],
  }
]
