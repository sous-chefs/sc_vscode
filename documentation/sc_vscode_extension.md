# sc_vscode_extension

Installs or uninstalls an extension for a user. Extensions are user specific

## Actions

- `:install`
- `:uninstall`

## Properties

| Name              | Type   | Required | Description                                                                        |
| ----------------- | ------ | -------- | ---------------------------------------------------------------------------------------- |
| extension_name    | String | true     | The name of the extension you wish to install/uninstall                                  |
| user              | String | true     | The name of the user who you wish to install the extension for                           |
| home_dir          | String | false    | The location of the home dir for the user, defaults to: `::File.expand_path("~#{user}")` |

### Examples

Install the ruby extension for vagrant user

```ruby
sc_vscode_extension 'rebornix.ruby' do
  user 'vagrant'
end
```
