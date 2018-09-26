# vscode

Provides a set of resources to aid in the installation and management of vscode extensions

## Requirements

- code accessible on path

### Chef

- Chef 13 +

## Resources

### extensions

Installs or uninstalls extensions 

#### Actions
- `:install` - installs/upgrades the extension
- `:uninstall` - Removes the extension from vscode


#### Properties

- `extension_name` - (Required) name attribute, String, The name of the extension you wish to install/uninstall
