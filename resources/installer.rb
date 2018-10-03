# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html

action :install do
  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    yum_repository 'vscode' do
      description 'Visual Studio Code'
      baseurl     node['vscode']['rhel']['repository']
      enabled     true
      gpgcheck    true
      gpgkey      node['vscode']['signing_key']
    end
    package_name = node['vscode']['rhel']['name']
  when 'debian'
    apt_repository 'vscode' do
      uri           node['vscode']['deb']['repository']
      components    node['vscode']['deb']['components']
      distribution  node['vscode']['deb']['distribution']
      key           node['vscode']['signing_key']
      cache_rebuild true
    end
    # Requirement for debian
    package 'apt-transport-https' do
      action :install
    end
    package_name = node['vscode']['deb']['name']
  when 'windows'
    package_name = node['vscode']['windows']['name']
  else
    raise "platform family not supported: #{node['platform_family']}"
  end

  package package_name do
    action :install
  end
end

action :uninstall do
  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    yum_repository 'vscode' do
      action :delete
    end
    package_name = node['vscode']['rhel']['name']
  when 'debian'
    apt_repository 'vscode' do
      action :delete
    end
    package_name = node['vscode']['deb']['name']
  when 'windows'
    package_name = node['vscode']['windows']['name']
  else
    raise "platform family not supported: #{node['platform_family']}"
  end
  package package_name do
    action :uninstall
  end
end
