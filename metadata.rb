# frozen_string_literal: true

name              'sc_vscode'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Installs and manages Visual Studio Code Extensions'
source_url        'https://github.com/sous-chefs/sc_vscode'
issues_url        'https://github.com/sous-chefs/sc_vscode/issues'
chef_version      '>= 15.3'
version           '2.0.13'

supports 'ubuntu', '>= 20.04'
supports 'redhat', '>= 8.0'
supports 'centos_stream', '>= 9.0'
supports 'fedora'

supports 'debian', '>= 12.0'
supports 'mac_os_x'
