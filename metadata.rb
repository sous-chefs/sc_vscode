name              'vscode'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Installs and manages Visual Studio Code Extensions'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.0.1'
source_url        'https://github.com/sous-chefs/vscode'
issues_url        'https://github.com/sous-chefs/vscode/issues'
chef_version '>= 13.0'

%w(ubuntu debian redhat amazon centos windows fedora).each do |os|
  supports os
end
