# Testing sc_vscode

Use Cinc or Chef Workstation to resolve the Policyfile and run unit checks:

```sh
cinc install Policyfile.rb
cinc exec rspec
cookstyle
```

Linux integration runs in disposable amd64 Docker containers. List and test a
single instance with:

```sh
KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen list
KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test default-ubuntu-2404 --destroy=always
```

Each test converges twice and requires zero updated resources on the second
converge, then runs the InSpec profile under `test/integration/default`. Keep
the Linux platform lists in `kitchen.yml`, `kitchen.dokken.yml` and CI aligned.
`kitchen.global.yml` contains shared settings and no separate platform list.

The macOS exec driver changes the host. Run it only on a disposable hosted CI
runner. Apple Silicon Docker hosts without amd64 emulation must use hosted
amd64 Linux CI for the existing amd64 package-installation contract.
