include Vscode::Helper
unified_mode true
signing_key = 'https://packages.microsoft.com/keys/microsoft.asc'

action :install do
  case node['platform_family']
  when 'rhel', 'fedora'
    yum_repository 'vscode' do
      description 'Visual Studio Code'
      baseurl     'https://packages.microsoft.com/yumrepos/vscode'
      enabled     true
      gpgcheck    true
      gpgkey      signing_key
    end

  when 'debian'
    apt_repository 'vscode' do
      uri           'https://packages.microsoft.com/repos/vscode'
      arch          'amd64'
      components    ['main']
      distribution  'stable'
      key           signing_key
    end
    package 'apt-transport-https'
  end

  package vscode_pkg_deps if node['os'] == 'linux'

  if platform?('mac_os_x')
    homebrew_cask 'visual-studio-code'
  else
    package code_installer_name
  end
end

action :uninstall do
  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    yum_repository 'vscode' do
      action :remove
    end
  when 'debian'
    apt_repository 'vscode' do
      action :remove
    end
  end

  if platform?('mac_os_x')
    homebrew_cask 'visual-studio-code' do
      action :remove
    end
  else
    package code_installer_name do
      action :remove
    end
  end
end

# this is me 
# making some changes
# to trigger dangerfile 
# hopefully
