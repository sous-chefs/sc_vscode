# sc_vscode maintenance

## Confirmed scope

The owner selected a full custom-resource migration on 12 November 2026. The
cookbook already exposes `sc_vscode_installer` and `sc_vscode_extension` and has
no public recipes or attributes. Preserve these resource names and actions.
Do not describe CI-only repairs as completion of that migration.

## Vendor evidence

Microsoft documents Debian/Ubuntu APT packages and RHEL/Fedora/CentOS RPM
packages at <https://code.visualstudio.com/docs/setup/linux>. The repository
signing key is <https://packages.microsoft.com/keys/microsoft.asc>. The existing
Debian resource hard-codes amd64; do not advertise ARM support without changing
and testing the repository architecture. macOS uses the Homebrew cask.
This cookbook installs binary packages; it does not build VS Code from source.

Check current vendor prerequisites at
<https://code.visualstudio.com/Docs/supporting/requirements> before changing the
supported platform matrix. Preserve supported non-EOL platforms. Kitchen,
Dokken and CI currently disagree and contain obsolete systems; fixing one file
alone does not establish platform coverage.

## Findings from the release audit

* Both public resources use unified mode and explicit `provides` names.
* Extension uninstall must pass `home_dir` through every installed-state check.
* Keep real ChefSpec convergence and lifecycle assertions; evaluating a symbol
  inside an exception expectation does not run the resource.
* CI resolves Policyfile dependencies through `chef-cli`, supplied by the shared
  workflow's `gems` input. Do not restore the obsolete Berkshelf require.
* Keep the Policyfile, default test cookbook, InSpec profile and Kitchen/CI
  matrices aligned. Require two converges and zero updates on the second.
* Dokken is appropriate for Linux package tests. Keep macOS integration isolated
  from Linux containers. Do not converge the installer on the maintainer's Mac.

## Platform and verification decisions

Retain Ubuntu 20.04 for Ubuntu Pro ESM systems. Retain the openSUSE platform
family, using the official Leap 16.0 image, and configure the Microsoft
RPM repository through `zypper_repository`. Keep the existing supported Linux
families; obsolete release removal is documented in `migration.md`.

Reference lifecycle evidence:

* <https://endoflife.date/centos-stream>
* <https://www.debian.org/News/2026/20260831>
* <https://ubuntu.com/project/docs/release-team/list-of-releases/>

Linux containers run `sleep` as PID 1 because this cookbook manages packages and
extensions, not system services. Linux integration still targets amd64. The
local Apple Silicon Docker daemon cannot execute amd64 binaries (`exec format
error` even for `/bin/sleep`), so obtain Kitchen evidence on hosted amd64 CI.

## Release sequencing

The owner chose to replace the pending 2.1.0 release with a major migration.
Land a `feat!` feature PR first, then verify release-please generates 3.0.0.
Do not publish these changes by merging the old 2.1.0 release unchanged.

## Proven integration fixes

Use the current APT URI `https://packages.microsoft.com/repos/code`. VS Code's
package post-install script recognises that URI and preserves the managed
repository. The old `/repos/vscode` URI causes the package to replace the
managed `.list` file with a `.sources` file, breaking the second converge.
See <https://github.com/microsoft/vscode/blob/main/resources/linux/debian/postinst.template>.
On macOS the preinstalled workstation client is under `/opt/cinc-workstation`,
not the standalone client's `/opt/cinc` directory.

Fedora 45 ships OpenSSL 4, but VS Code's extension verifier still needs the
OpenSSL 3 compatibility library. Install `openssl3-libs` on Fedora 45 and later;
do not disable extension signature verification. Upstream evidence:
<https://github.com/microsoft/vscode/issues/338194>.

Use the CLI's targeted `--install-extension <id> --force` update path rather than
uninstalling and reinstalling an existing extension. The current CLI compares
the marketplace version and skips installation when that version is already
present. This preserves automatic updates without transient removal on every
converge. Source:
<https://github.com/microsoft/vscode/blob/main/src/vs/platform/extensionManagement/common/extensionManagementCLI.ts>.
