# frozen_string_literal: true

require 'spec_helper'

describe 'sc_vscode_extension' do
  step_into :sc_vscode_extension
  platform 'ubuntu', '24.04'

  recipe do
    sc_vscode_extension 'example.extension' do
      user 'tester'
      home_dir '/home/tester'
      action :uninstall
    end
  end

  it 'uses the supplied home directory to find and remove the extension' do
    listing = double('listing', run_command: nil, exitstatus: 0, stdout: "example.extension@1.0.0\n")
    removal = double('removal', run_command: nil, exitstatus: 0, stdout: 'successfully uninstalled')
    allow(listing).to receive(:run_command).and_return(listing)
    allow(removal).to receive(:run_command).and_return(removal)
    expect(Mixlib::ShellOut).to receive(:new).with('code --list-extensions --show-versions', user: 'tester', environment: { 'HOME' => '/home/tester' }).twice.and_return(listing)
    expect(Mixlib::ShellOut).to receive(:new).with('code --uninstall-extension example.extension', user: 'tester', environment: { 'HOME' => '/home/tester' }).and_return(removal)
    expect { chef_run }.not_to raise_error
  end
end
