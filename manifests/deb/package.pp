# == Class: murmur::deb::package
#  wrapper class
#
class murmur::deb::package {
  Package{} -> Anchor['murmur::package::end']
  # end of variables
  case $murmur::ensure {
    present, enabled, active, disabled, stopped: {
      #everything should be installed
      package { 'mumble-server':
        ensure => 'present',
      } -> Anchor['murmur::package::end']
    }#end present case
    absent: {
      #everything should be removed
      package { 'mumble-server':
        ensure => 'absent',
      } -> Anchor['murmur::package::end']
    }#end absent case
    default: {
      notice "murmur::ensure has an unsupported value of ${murmur::ensure}."
    }#end default ensure case
  }#end ensure case
}#end class
