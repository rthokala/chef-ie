# https://code.google.com/p/selenium/wiki/InternetExplorerDriver#Required_Configuration
major_version = ie_version.split('.')[0].to_i

# For IE 11 only, you will need to set a registry entry on the target computer so that the driver can maintain a
# connection to the instance of Internet Explorer it creates.
include_recipe 'ie::bfcache' if major_version >= 11

include_recipe 'ie::esc' # disable annoying enhanced security configuration

include_recipe 'ie::firstrun' if major_version == 9 || major_version == 8

# On IE 7 or higher, you must set the Protected Mode settings for each zone to be the same value.
# The value can be on or off, as long as it is the same or every zone.
if major_version >= 7
  node.set['ie']['zone']['internet'] = {
    '1400' => 0, # enable active scripting
    '2500' => 0 # enable protected mode
  }

  node.set['ie']['zone']['local_internet'] = {
    '2500' => 0 # enable protected mode
  }

  node.set['ie']['zone']['trusted_sites'] = {
    '2500' => 0 # enable protected mode
  }

  node.set['ie']['zone']['restricted_sites'] = {
    '2500' => 0 # enable protected mode
  }

  include_recipe 'ie::zone'
end

include_recipe 'ie::zoom' # set zoom level to 100%
