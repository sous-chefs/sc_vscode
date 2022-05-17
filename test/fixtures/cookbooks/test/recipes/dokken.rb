# Make sure Vagrant user is on the box. This should fix the dokken user install
user node['user'] do
  not_if { platform? == 'mac_os_x' }
end

group node['user'] do
  members node['user']
end

directory '/home/vagrant' do
  owner node['user']
  group node['user']
  not_if { platform?('windows') }
  not_if { platform?('mac_os_x') }
end

package_required = case node['platform_family']
                   when 'rhel', 'amazon', 'fedora'
                     'libxshmfence'
                   when 'debian'
                     'libxshmfence1'
                   end

package package_required if package_required
