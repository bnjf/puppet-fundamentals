
class hosts {
  host { "testing.puppetlabs.vm":
    ip      => "127.0.0.1",
    comment => "Lab 8.1",
    ensure  => present,
  }
}
