# frozen_string_literal: true

require 'spec_helper'
require_relative '../../libraries/helper'

describe Vscode::Helper do
  let(:helper) { Class.new { include Vscode::Helper }.new }

  it 'reports the CLI exit status and error output when an extension command fails' do
    result = double('command', exitstatus: 1, stderr: 'extension download failed')
    allow(result).to receive(:run_command).and_return(result)
    allow(Mixlib::ShellOut).to receive(:new).and_return(result)

    expect { helper.code_command('--install-extension example.extension', 'tester', '/home/tester') }
      .to raise_error(RuntimeError, /exit 1.*extension download failed/)
  end

  context 'checking an installed extension for updates' do
    before do
      expect(helper).not_to receive(:code_uninstall_package)
      expect(helper).to receive(:code_command)
        .with('--install-extension example.extension --force', 'tester', '/home/tester')
    end

    it 'leaves an unchanged version installed and reports no update' do
      allow(helper).to receive(:code_installed_packages)
        .and_return({ 'example.extension' => '1.0.0' }, { 'example.extension' => '1.0.0' })

      expect(helper.code_upgrade_package('Example.Extension', 'tester', '/home/tester')).to be_nil
    end

    it 'reports an update when the selected extension version changes' do
      allow(helper).to receive(:code_installed_packages)
        .and_return({ 'example.extension' => '1.0.0' }, { 'example.extension' => '1.1.0' })

      expect(helper.code_upgrade_package('Example.Extension', 'tester', '/home/tester')).to be true
    end
  end
end
