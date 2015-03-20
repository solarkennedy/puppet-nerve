# == Class nerve::intall
#
class nerve::install {

  if ! $nerve::package_name {
    # In the case where a package name is not specified
    # Try to guess what the package name should be based on the provider
    case $nerve::package_provider {
      'gem','Gem': { $package_name = 'nerve' }
      default:     { $package_name = 'rubygem-nerve' }
    }
  } else {
    # Use the package name they asked for
    $package_name = $nerve::package_name
  }

  package { 'nerve':
    ensure   => $nerve::package_ensure,
    name     => $package_name,
    provider => $nerve::package_provider,
  }

}
