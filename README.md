# IE Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/ie.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-ie.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-ie.svg?style=flat-square)][github]

[cookbook]: https://supermarket.chef.io/cookbooks/ie
[travis]: https://travis-ci.org/dhoer/chef-ie
[github]: https://github.com/dhoer/chef-ie/issues

The following recipes are available for configuring Internet Explorer:

- **[BFCache](https://github.com/dhoer/chef-ie#bfcache)** - Enable/Disable IE Feature Back-Forward Cache
- **[ESC](https://github.com/dhoer/chef-ie#esc)** - Enable/Disable IE Enhanced Security Configuration
- **[Zone](https://github.com/dhoer/chef-ie#zone)** - Configure IE Security Zones;
Local Home, Internet, Local Internet, Trusted Sites, and Restricted Sites

A `ie_version` method is also available to retrieve the exact version of Internet Explorer installed.

Tested against:

- IE 11 on Windows Server 2012 R2
- IE 10 on Windows Server 2008 R1
- IE 9 on Windows Server 2003 R2

## Requirements

- Chef 11.6.0 or higher (includes a built-in registry_key resource)

## Platforms

- Windows

## Usage

See [ie_test](https://github.com/dhoer/chef-ie/tree/master/test/fixtures/cookbooks/ie_test) cookbook for examples.
Include `ie` as a dependency to make `ie_version` method available. Note that there is no default recipe.

A library method `ie_version` is provided to retrieve the IE version installed:

```ruby
v = ie_version
```

**Tip:** use `allow_any_instance_of` to stub ie_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:ie_version).and_return('11.0.0.0')
```



## BFCache

Enable/Disable IE Feature Back-Forward Cache.  Allows drivers to maintain a connection to IE.

### Attributes

- `node['ie']['bfcache']` - Defaults to `true` (enabled)

### Example

Enable bfcache:

```ruby
include_recipe 'ie::bfcache'
```



## ESC

Enable/Disable Internet Explorer Enhanced Security Configuration (ESC).

### Attributes

- `node['ie']['esc']` - Defaults to `false` (disabled)

### Example

Disable enhanced security configuration:

```ruby
include_recipe 'ie::esc'
```



## Zone

Configure IE Security Zones (REG_DWORD types only); Local Home, Internet, Local Internet, Trusted Sites, and
Restricted Sites.

See Zones section in http://support.microsoft.com/kb/182569 for a complete listing of security zone
settings.

A setting of zero sets a specific action as permitted, a setting of one causes a prompt to appear, and a setting
of three prohibits the specific action.

### Attributes

- `node['ie']['zone']['local_home']` - Configure local home zone.  Defaults to `{}`.
- `node['ie']['zone']['internet']` - Configure internet zone.  Defaults to `{ '2500' => 0 }` (Enable Protected Mode).
- `node['ie']['zone']['local_internet']` - Configure local internet zone. Defaults `{ '2500' => 0 }`
(Enable Protected Mode).
- `node['ie']['zone']['trusted_sites']` - Configure trusted sites zone. Defaults to `{ '2500' => 0 }`
(Enable Protected Mode).
- `node['ie']['zone']['restricted_sites']` - Configure restricted sites zone. Defaults to `{ '2500' => 0 }`
(Enable Protected Mode).

### Example

Enable both protected mode and javascript for internet zone:

```ruby
node.set['ie']['zone']['internet'] = {
  '2500' => 0, # enable protected zone
  '1400' => 0  # enable javascript
}
include_recipe 'ie::zone'
```



## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-ie).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-ie/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-ie/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-ie/blob/master/LICENSE.md) file for details.
