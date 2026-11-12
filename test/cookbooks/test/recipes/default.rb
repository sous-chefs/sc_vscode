# frozen_string_literal: true

sc_vscode_installer 'install'

if platform?('mac_os_x')
  test_user = ENV.fetch('USER')
  test_home = ENV.fetch('HOME')
else
  test_user = 'vscode-test'
  test_home = '/home/vscode-test'
  user test_user do
    home test_home
    manage_home true
  end
end

sc_vscode_extension 'rebornix.ruby' do
  user test_user
  home_dir test_home
end
