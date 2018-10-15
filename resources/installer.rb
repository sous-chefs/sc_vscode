# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html

include Vscode::Helper

action :install do
  signing_key = 'https://packages.microsoft.com/keys/microsoft.asc'
  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    yum_repository 'vscode' do
      description 'Visual Studio Code'
      baseurl     'https://packages.microsoft.com/yumrepos/vscode'
      enabled     true
      gpgcheck    true
      gpgkey      signing_key
    end
    if node['platform_family'] == 'amazon'
    # Requirement for debian
    package 'epel-release' do
      action :install
    end
    end
  when 'debian'
    apt_repository 'vscode' do
      uri           'https://packages.microsoft.com/repos/vscode'
      arch          'amd64'
      components    ['main']
      distribution  'stable'
      key           signing_key
    end
    # Requirement for debian
    package 'apt-transport-https' do
      action :install
    end
  end

  package_name = code_installer_name
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
  when 'debian'
    apt_repository 'vscode' do
      action :delete
    end
  end

  package_name = code_installer_name
  package package_name do
    action :uninstall
  end
end
