# Migrating to sc_vscode 3

The public resource names and actions stay the same:

* `sc_vscode_installer`: `:install` and `:uninstall`.
* `sc_vscode_extension`: `:install` and `:uninstall`.

This cookbook already had no public recipes or attributes. Consumers do not
need to replace recipe includes or node attributes. Extension removal now uses
the configured `home_dir` when checking whether the extension is installed.

The major release removes end-of-life CentOS Linux, CentOS Stream 8, Debian 9,
Debian 10, Debian 11 and obsolete interim Ubuntu integration targets. Ubuntu
20.04 stays in the matrix for systems using Ubuntu Pro ESM. The openSUSE family
stays in the matrix. Linux package tests still use amd64, matching the existing
APT repository configuration.

Development and test dependency resolution now uses `Policyfile.rb`. Run
`chef install Policyfile.rb`, `chef exec rspec`, then select a Kitchen instance
with `KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen list`. The default test
cookbook is under `test/cookbooks/test`; its default recipe installs VS Code
and an extension for a dedicated test user. macOS tests use a separate exec
driver and must run only on a disposable CI runner.
