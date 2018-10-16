# Make sure that Vagarant user is on the box for dokken
include_recipe 'test::dokken'

vscode_installer 'install' do
end

# We need a couple prereqs for testing as servers do not have a GUI,
# this is not expected in live, as no one would install vscode without a GUI?
case node[:platform]
when 'fedora'
  package_name = 'libX11-xcb'
when 'ubuntu', 'debian'
  package_name = ['libx11-xcb1', 'libxss1', 'libasound2', 'libxkbfile1']
end

package 'testing-prereqs' do
  package_name package_name
  not_if { package_name.nil? }
end

vscode_extension 'rebornix.ruby' do
  user 'vagrant'
end
