# vscode CHANGELOG

This file is used to list changes made in each version of the vscode cookbook.

## [3.0.0](https://github.com/sous-chefs/sc_vscode/compare/v2.0.13...v3.0.0) (2026-11-12)


### ⚠ BREAKING CHANGES

* support current VS Code platforms

### Features

* **circleci:** Remove circleci as not needed ([#67](https://github.com/sous-chefs/sc_vscode/issues/67)) ([f8332af](https://github.com/sous-chefs/sc_vscode/commit/f8332afbdd645a190d41e266084a31e725f7e5bd))
* **danger:** Add Danger via github actions ([5dc016c](https://github.com/sous-chefs/sc_vscode/commit/5dc016c91c8efc9bda0f198f5e7d4b0d797c6642))
* **danger:** Try to trigger again ([bddb3aa](https://github.com/sous-chefs/sc_vscode/commit/bddb3aabb8c704f8240f4a55499426787f04c2d8))
* support current VS Code platforms ([316f6f0](https://github.com/sous-chefs/sc_vscode/commit/316f6f01440c84d6a1c9f799748c8ba9da1b0e2d))


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#99](https://github.com/sous-chefs/sc_vscode/issues/99)) ([8c7c284](https://github.com/sous-chefs/sc_vscode/commit/8c7c2849ddad2884c115e02beadff131b04e8fc2))
* declare verified VS Code platform support ([31736a9](https://github.com/sous-chefs/sc_vscode/commit/31736a902d88821ddfb25652dd338aaa52ab22db))

## [2.0.13](https://github.com/sous-chefs/sc_vscode/compare/2.0.12...v2.0.13) (2025-10-16)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#99](https://github.com/sous-chefs/sc_vscode/issues/99)) ([8c7c284](https://github.com/sous-chefs/sc_vscode/commit/8c7c2849ddad2884c115e02beadff131b04e8fc2))

## 2.0.11 - *2024-07-10*

* Triggering a release to check systems are working

## 2.0.9 - *2024-01-04*

* Bump github actions

## 2.0.3 - *2023-03-22*

troubleshooting more

## 2.0.2 - *2023-03-22*

troubleshooting our release system

## 2.0.1 - *2022-11-02*

* Removes CircleCI Danger CI
* Adds Github Actions Danger CI
* Removes ubuntu16 testingy

## 2.0.0 - *2022-05-17*

* Add unified_mode for Chef 17 support
* Bump minimum Chef verison to 15.3 for unified_mode
* Add MacOS testing

## 1.0.6 - *2021-06-18*

* Standard Files Update

## 1.0.5 - *2021-06-01*

* Standard Files update

## 1.0.4 - *2020-12-02*

* resolved cookstyle error: resources/installer.rb:39:7 warning: `Chef/Deprecations/DeprecatedYumRepositoryActions`
* Install libxcb which is required to properly install extensions
* Remove Debian 8 testing
* Add Debian 10, EL8 and Ubuntu 20.04 testing

## 1.0.3 - *2020-11-18*

* fixed yamllint warning for "on" in the ci workflow

## 1.0.2

* Migrated to actions for testing

## 1.0.1

* Added `.gitattributes` to ensure `lf` line endings
* Updated circleci builds to be parallel
* Updated cookbook with latest `cookstyle` fixes
* Changed `Dangerfile` to use `failure` instead of `fail`
* Removed `.rubocop.yml` as no longer required

## 1.0.0

* Added extension management
* Can install extensions
* Can upgrade extensions
* Can uninstall extensions
* Added installation management
* Can install vscode and related repository
* Can uninstall vscode and related repository
* Added initial support for Linux
