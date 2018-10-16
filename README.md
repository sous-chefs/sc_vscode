# vscode

Provides a set of resources to aid in the installation and management of vscode extensions

## Requirements

- code accessible on path

### Chef

- Chef 13 +

## Resources

### extensions

Installs or uninstalls extensions for a user. Extensions are user specific

#### Actions

- `:install` - installs/upgrades the extension
- `:uninstall` - Removes the extension from vscode

#### Properties

- `extension_name` - (Required) name attribute, String, The name of the extension you wish to install/uninstall
- `user` - (Required) String, The name of the user who you wish to install the extension for
- `home_dir` - (Optional) String, The location of the home dir for the user, if not in /home/user or C:\users\user

### installer

Installs or uninstalls visual studio code

#### Actions

- `:install` - installs visual studio code and any required repositories
- `:uninstall` - uninstalls visual studio code and any required repositories
