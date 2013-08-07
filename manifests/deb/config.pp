# == Class: murmur::deb::config
#  wrapper class
#
#  iptables rule should we ever decide to add iptables rules automagically:
#      -A RH-Firewall-1-INPUT -p tcp -m tcp --dport murmurport -j ACCEPT
#      -A RH-Firewall-1-INPUT -p udp -m udp --dport murmurport -j ACCEPT
#
class murmur::deb::config {
Anchor['murmur::package::end'] -> Class['murmur::deb::config']
  #make our parameters local scope
  File{} -> Anchor['murmur::config::end']
  #clean up our parameters
  $ensure             = $murmur::ensure
  $allowhtml          = $murmur::allowhtml
  $autoban_attempts   = $murmur::autoban_attempts
  $autoban_timeframe  = $murmur::autoban_timeframe
  $autoban_time       = $murmur::autoban_time
  $bandwidth          = $murmur::bandwidth
  $configfilepath     = $murmur::configfilepath
  $database           = $murmur::database
  $host               = $murmur::host
  $imagemessagelength = $murmur::imagemessagelength
  $logdays            = $murmur::logdays
  $logfile            = $murmur::logfile
  $logrotate          = $murmur::logrotate
  $pidfile            = $murmur::pidfile
  $port               = $murmur::port
  $rpc                = $murmur::rpc
  $serverpassword     = $murmur::serverpassword
  $sslcert            = $murmur::sslcert
  $sslkey             = $murmur::sslkey
  $textmessagelength  = $murmur::textmessagelength
  $users              = $murmur::users
  $uname              = $murmur::uname
  $welcometext        = $murmur::welcometext
  case $ensure {
    present, enabled, active, disabled, stopped: {
      #everything should be installed
      file {'murmur_conf':
        ensure  => 'present',
        path    =>  $configfilepath,
        mode    => '0440',
        content => template('murmur/etc/mumble-server.ini.erb'),
        require => Package['mumble-server'],
      }#end murmur_conf file

    }#end configfiles should be present case
    absent: {
      file {'murmur_conf':
        ensure  => 'absent',
        path    =>  $configfilepath,
      }#end murmur_conf file

    }#end configfiles should be absent case
    default: {
      notice "murmur::ensure has an unsupported value of ${murmur::ensure}."
    }#end default ensure case
  }#end ensure case
}#end class
