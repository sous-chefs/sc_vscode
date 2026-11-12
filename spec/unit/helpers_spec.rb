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
end
