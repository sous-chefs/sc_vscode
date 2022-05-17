# frozen_string_literal: true

control 'installation' do
  impact 1.0
  title 'VSCode should be installed'
  describe command('code').exist? do
    it { should eq true }
  end
end

if os.family == 'darwin'
  control 'extensions' do
    impact 1.0
    title 'Ruby Extension should be installed'
    describe command('code --list-extensions') do
      its('exit_status') { should eq 0 }
      its('stdout') { should match(/Ruby/i) }
    end
  end
else
  control 'extensions' do
    impact 1.0
    title 'Ruby Extension should be installed'
    describe command('su - vagrant -c "code --list-extensions"') do
      its('exit_status') { should eq 0 }
      its('stdout') { should match(/Ruby/i) }
    end
  end
end
