# frozen_string_literal: true
vscode_installer 'install' do
end

# vscode_extension 'rebornix.ruby' do
#   user 'vagrant'
# end

execute 'install' do
  command "code --install-extension rebornix.ruby"
  user 'vagrant'
end

