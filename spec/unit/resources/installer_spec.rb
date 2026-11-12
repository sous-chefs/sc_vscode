# frozen_string_literal: true

require 'spec_helper'

describe 'sc_vscode_installer' do
  step_into :sc_vscode_installer
  platform 'ubuntu', '24.04'

  context 'installation' do
    recipe do
      sc_vscode_installer 'editor'
    end

    it { is_expected.to install_package('code') }
    it { is_expected.to add_apt_repository('vscode').with(uri: 'https://packages.microsoft.com/repos/code') }
  end

  context 'uninstallation' do
    recipe do
      sc_vscode_installer 'editor' do
        action :uninstall
      end
    end

    it { is_expected.to remove_package('code') }
    it { is_expected.to remove_apt_repository('vscode') }
  end

  context 'Fedora 45 extension signature verification' do
    # Bundled Fauxhai only has older Fedora fixtures; this rule uses the version.
    platform 'fedora', '32'
    automatic_attributes['platform_version'] = '45'

    recipe do
      sc_vscode_installer 'editor'
    end

    it { is_expected.to install_package('openssl3-libs') }
  end
end
