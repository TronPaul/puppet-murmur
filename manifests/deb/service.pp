# == Class: murmur::deb::service
#  wrapper class
class murmur::deb::service {
Anchor['murmur::config::end'] -> Class['murmur::deb::service']
  Service{} -> Anchor['murmur::service::end']
  # end of variables
  case $murmur::ensure {
    enabled, active: {
      #everything should be installed, but puppet is not managing the state of the service
      service {'mumble-server':
        ensure    => running,
        enable    => true,
        subscribe => File['murmur_conf'],
        require   => Package['mumble-server'],
        hasstatus => true,
      }#end service definition
    }#end enabled class
    disabled, stopped: {
      service {'mumble-server':
        ensure    => stopped,
        enable    => false,
        subscribe => File['murmur_conf'],
        hasstatus => true,
      }#end service definition
    }#end disabled
    default: {
      #nothing to do, puppet shouldn't care about the service
    }#end default ensure case
  }#end ensure case
}#end class
