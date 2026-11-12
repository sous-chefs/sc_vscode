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

# A reinstall changes the extension files even if the reported version stays the
# same. Keep this marker stable across both converges to catch that behaviour.
file ::File.join(test_home, 'extension-installation-state') do
  content lazy {
    manifests = ::Dir.glob(::File.join(test_home, '.vscode', 'extensions', 'rebornix.ruby-*', 'package.json'))
    raise 'Ruby extension installation was not found' if manifests.empty?

    manifests.sort.map { |path| "#{path}:#{::File.stat(path).ctime.to_f}" }.join("\n")
  }
end
