# vscode CHANGELOG

This file is used to list changes made in each version of the vscode cookbook.

## Unreleased

troubleshooting our release system 

## 2.0.1 - *2022-11-02*

- Removes CircleCI Danger CI
- Adds Github Actions Danger CI
- Removes ubuntu16 testingy

## 2.0.0 - *2022-05-17*

- Add unified_mode for Chef 17 support
- Bump minimum Chef verison to 15.3 for unified_mode
- Add MacOS testing

## 1.0.6 - *2021-06-18*

- Standard Files Update

## 1.0.5 - *2021-06-01*

- Standard Files update

## 1.0.4 - *2020-12-02*

- resolved cookstyle error: resources/installer.rb:39:7 warning: `Chef/Deprecations/DeprecatedYumRepositoryActions`
- Install libxcb which is required to properly install extensions
- Remove Debian 8 testing
- Add Debian 10, EL8 and Ubuntu 20.04 testing

## 1.0.3 - *2020-11-18*

- fixed yamllint warning for "on" in the ci workflow

## 1.0.2

- Migrated to actions for testing

## 1.0.1

- Added `.gitattributes` to ensure `lf` line endings
- Updated circleci builds to be parallel
- Updated cookbook with latest `cookstyle` fixes
- Changed `Dangerfile` to use `failure` instead of `fail`
- Removed `.rubocop.yml` as no longer required

## 1.0.0

- Added extension management
- Can install extensions
- Can upgrade extensions
- Can uninstall extensions
- Added installation management
- Can install vscode and related repository
- Can uninstall vscode and related repository
- Added initial support for Linux
