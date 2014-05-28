class mongodb::params{
  case $::osfamily {
    'redhat': {
      $baseurl = "http://downloads-distro.mongodb.org/repo/redhat/os/${::architecture}"
      $source  = 'mongodb::sources::yum'
      $package = 'mongodb-server'
      $service = 'mongod'
      $pkg_10gen = 'mongo-10gen-server'
      $mongofork = true
      $confpath = '/etc/mongod.conf'
      $logpath = '/var/log/mongo/mongod.log'
      $dbpath = '/var/lib/mongo/'
    }
    'debian': {
      $locations = {
        'sysv'    => 'http://downloads-distro.mongodb.org/repo/debian-sysvinit',
        'upstart' => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart'
      }
      case $::operatingsystem {
        'Debian': { $init = 'sysv' }
        'Ubuntu': { $init = 'upstart' }
      }
      $source  = 'mongodb::sources::apt'
      $package = 'mongodb'
      $service = 'mongod'
      $pkg_10gen = 'mongodb-org'
      $mongofork = false
      $confpath = '/etc/mongod.conf'
      $logpath = '/var/log/mongodb/mongod.log'
      $dbpath = '/var/lib/mongodb/'
    }
    default: {
      fail ("mongodb: ${::operatingsystem} is not supported.")
    }
  }
}
