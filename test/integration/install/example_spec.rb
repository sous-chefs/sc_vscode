# frozen_string_literal: true
title 'VScode should be installed'

describe command('code --version') do
  its('exit_status') { should eq 0 }
end