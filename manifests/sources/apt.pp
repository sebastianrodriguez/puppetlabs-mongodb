class mongodb::sources::apt inherits mongodb::params {
  include apt

  if $mongodb::location {
    $location = $mongodb::location
  } else {
    $location = $mongodb::params::locations[$mongodb::init]
  }

  apt::source { '10gen':
    location    => $location,
    release     => 'dist',
    repos       => '10gen',
    key         => { 
      id        => '492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10', 
      server    => 'keyserver.ubuntu.com'
    },
    include     => { 
      src       => false 
    },
    notify => [ Exec['apt-get-update'] ]
  }

  exec { 'apt-get-update':
      command     => '/usr/bin/apt-get update -y --force-yes',
      refreshonly => true,
      environment => 'DEBIAN_FRONTEND=noninteractive',
    }
}
