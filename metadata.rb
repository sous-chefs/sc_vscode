name              'sc_vscode'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Installs and manages Visual Studio Code Extensions'
source_url        'https://github.com/sous-chefs/vscode'
issues_url        'https://github.com/sous-chefs/vscode/issues'
<<<<<<< HEAD
chef_version      '>= 13.0'
version           '1.0.10'
=======
chef_version      '>= 15.3'
version           '1.0.6'
>>>>>>> b31c2fb (Unified Mode and MacOS testing)

%w(ubuntu redhat centos fedora).each do |os|
  supports os
end
