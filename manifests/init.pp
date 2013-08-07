# == Class: murmur
#
# This module enables the configuration and management of a Ventrillo
# Server. see www.ventrillo.com for details on murmur
# an RPM spec file, an RPM, init script, and config template are provided.
#
# === Parameters
#
#
# [*murmur_ensure*]
#   whether or not to install and enable the service#
#
# [*murmur_allowhtml*]
#   Allow clients to use HTML in messages, user comments and channel descriptions?
#
# [*murmur_autoban_attempts*]
# [*murmur_autoban_timeframe*]
# [*murmur_autoban_time*]
#   How many login attempts do we tolerate from one IP inside a given timeframe
#   before we ban the connection? Note that this is global (shared between all
#   virtual servers), and that it counts both successfull and unsuccessfull
#   connection attempts. Set either Attempts or Timeframe to 0 to disable.
#
# [*murmur_bandwidth*]
#   Maximum bandwidth (in bits per second) clients are allowed
#   to send speech at.
#
# [*murmur_configfilepath*]
#   The name of the config file
#
# [*murmur_database*]
#   Path to database. If blank, will search for
#   murmur.sqlite in default locations or create it if not found.
#
# [*murmur_host*]
#
# [*murmur_imagemessagelength*]
#   Maximum length of text messages in characters, with image data. 0 for no limit.
#
# [*murmur_logdays*]
#   Murmur retains the per-server log entries in an internal database which
#   allows it to be accessed over D-Bus/ICE. How many days should such entries
#   be kept? Set to 0 to keep forever, or -1 to disable logging to the DB
#
# [*murmur_logfile*]
#   Murmur default to logging to murmur.log. If you leave this blank, murmur
#   will log to the console (linux) or through message boxes (win32).
#
# [*murmur_logrotate*]
#    Whether or not to include the logrotate defined type and rotate the log
#
# [*murmur_pidfile*]
#    Murmur will write it's pid to this file
#
# [*murmur_port*]
#    Port to bind TCP and UDP sockets to
#
# [*murmur_rpc*]
#   Murmur defaults to using session for RPC. Supported options:
#   session
#   dbus
#
# [*murmur_serverpassword*]
#   Password to join server
#
# [*murmur_servername*]
#   The name the server displays
#
# [*murmur_sslcert*]
# [*murmur_sslkey*]
#   If you have a proper SSL certificate, you can provide the filenames here.
#   Otherwise, Murmur will create it's own certificate automatically.
#
# [*murmur_textmessagelength*]
#   Maximum length of text messages in characters. 0 for no limit.
#
# [*murmur_uname*]
#   If murmur is started as root, which user should it switch to? This option
#   is ignored if murmur isn't started with root privileges.
#
# [*murmur_users*]
#   Maximum number of concurrent clients allowed.
#
# [*murmur_welcometext*]
#   Welcome message sent to clients when they connect
#
# === Variables
#
# example hiera variable
#murmur_ensure:             'enabled'
#murmur_allowhtml:          'true'
#murmur_autoban_attempts:   '10'
#murmur_autoban_time:       '120'
#murmur_autoban_timeframe:  '300'
#murmur_bandwidth:          '72000'
#murmur_configfilepath:     '/etc/mumble-server.ini'
#murmur_database:           'murmur.sqlite'
#murmur_host:               ''
#murmur_imagemessagelength: '131072'
#murmur_logdays:            '31'
#murmur_logfile:            '/var/log/murmur.log'
#murmur_logrotate:          'false'
#murmur_pidfile:            ''
#murmur_port:               '64738'
#murmur_rpc:                'session'
#murmur_registername:       ''
#murmur_servername:         ''
#murmur_serverpassword:     ''
#murmur_sslcert:            ''
#murmur_sslkey:             ''
#murmur_textmessagelength:  '5000'
#murmur_uname:              'murmur'
#murmur_users:              '100'
#murmur_welcometext:        '"Welcome to mumble"'
# === Examples
#
#  class { murmur:
#    murmur_serverpassword => 'c@llMEmayb?'
#  }
#
# === To Do:
#
#  turn this into a defined type so multiple servers can be run on a box
#
# === Authors
#
# Wolf Noble <wolfspyre@wolfspaw.com>
#
# === Copyright
#
# Copyright 1999 Flagship Industries, unless otherwise noted.
#
class murmur(
  $murmur_ensure             = hiera('murmur_ensure',             'enabled'),
  $murmur_allowhtml          = hiera('murmur_allowhtml',          'true' ),
  $murmur_autoban_attempts   = hiera('murmur_autoban_attempts',   '10'),
  $murmur_autoban_time       = hiera('murmur_autoban_time',       '120'),
  $murmur_autoban_timeframe  = hiera('murmur_autoban_timeframe',  '120'),
  $murmur_bandwidth          = hiera('murmur_bandwidth',          '72000'),
  $murmur_configfilepath     = hiera('murmur_configfilepath',     '/etc/mumble-server.ini'),
  $murmur_database           = hiera('murmur_database',           'murmur.sqlite'),
  $murmur_host               = hiera('murmur_host',               ''),
  $murmur_imagemessagelength = hiera('murmur_imagemessagelength', '131072'),
  $murmur_logdays            = hiera('murmur_logdays',            '31'),
  $murmur_logfile            = hiera('murmur_logfile',            '/var/log/mumble-server/mumble-server.log'),
  $murmur_logrotate          = hiera('murmur_logrotate',          'false' ),
  $murmur_pidfile            = hiera('murmur_pidfile',            '/var/run/mumble-server/mumble-server.pid'),
  $murmur_port               = hiera('murmur_port',               '64738'),
  $murmur_rpc                = hiera('murmur_rpc',                'system'),
  $murmur_registername       = hiera('murmur_registername',       ''),
  $murmur_serverpassword     = hiera('murmur_serverpassword',     ''),
  $murmur_sslcert            = hiera('murmur_sslcert',            ''),
  $murmur_sslkey             = hiera('murmur_sslkey',             ''),
  $murmur_textmessagelength  = hiera('murmur_textmessagelength',  '5000'),
  $murmur_uname              = hiera('murmur_uname',              'murmur-server'),
  $murmur_users              = hiera('murmur_users',              '100'),
  $murmur_welcometext        = hiera('murmur_welcometext',        "\"<br />Welcome to ${::fqdn} running <b>Murmur</b>.<br />Enjoy your stay!<br />\""),

) {
  #take advantage of the Anchor pattern
  anchor{'murmur::begin':}
  -> anchor {'murmur::package::begin':}
  -> anchor {'murmur::package::end':}
  -> anchor {'murmur::config::begin':}
  -> anchor {'murmur::config::end':}
  -> anchor {'murmur::service::begin':}
  -> anchor {'murmur::service::end':}
  -> anchor {'murmur::end':}
  #clean up our parameters
  $ensure             = $murmur_ensure
  #$allowhtml          = $murmur_allowhtml
  case $murmur_allowhtml {
    /[tT][rR][uU][eE]/: {
      $allowhtml = true
    }
    /[fF][aA][lL][sS][eE]/: {
      $allowhtml = false
    }
    default: {
      fail "unsupported value $murmur_allowhtml for murmur_allowhtml. expecting a string with the value  true or false"
    }
  }
  $autoban_attempts   = $murmur_autoban_attempts
  $autoban_timeframe  = $murmur_autoban_timeframe
  $autoban_time       = $murmur_autoban_time
  $bandwidth          = $murmur_bandwidth
  $configfilepath         = $murmur_configfilepath
  $database           = $murmur_database
  $host               = $murmur_host
  $imagemessagelength = $murmur_imagemessagelength
  $logdays            = $murmur_logdays
  $logfile            = $murmur_logfile
  #$logrotate          = $murmur_logrotate
  case $murmur_logrotate {
    /[tT][rR][uU][eE]/: {
      $logrotate = true
    }
    /[fF][aA][lL][sS][eE]/: {
      $logrotate = false
    }
    default: {
      fail "unsupported value $murmur_logrotate for murmur_logrotate. expecting a string with the value  true or false"
    }
  }
  $pidfile            = $murmur_pidfile
  $port               = $murmur_port
  $registername       = $murmur_registername
  $rpc                = $murmur_rpc
  $serverpassword     = $murmur_serverpassword
  $sslcert            = $murmur_sslcert
  $sslkey             = $murmur_sslkey
  $textmessagelength  = $murmur_textmessagelength
  $users              = $murmur_users
  $uname              = $murmur_uname
  $welcometext        = $murmur_welcometext

  case $::osfamily {
    #RedHat Debian Suse Solaris Windows
    Debian: {
      include murmur::deb::package
      include murmur::deb::config
      include murmur::deb::service
    }#end Debian variant case
    default: {
      notice "There is not currently a murmur module for $::osfamily"
    }#end default unsupported OS case
  }
}#end of murmur class
