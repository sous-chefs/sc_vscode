#
# Author:: Jason Field (<jason@avon-lea.co.uk>)
# Cookbook:: vscode
# Library:: powershell_helper
#
# Copyright:: 2018, Jason Field
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/mixin/shell_out'

module Vscode
  module Helper
    include Chef::Mixin::ShellOut

    def code_installed?
      !code_version.nil?
    end

    def interpreter
      'code'
    end

    def code_version
      cmd = shell_out("#{interpreter} --version")
      cmd.stdout.split("\n")[0]
    rescue Errno::ENOENT
      nil
    end

    def code_installed_packages
      cmd = shell_out("#{interpreter} --list-extensions --show-versions")
      extensions = cmd.stdout.split("\n")
      result = {}
      extensions.each do |e|
        info = e.split('@')
        name = info[0]
        version = info[1]
        result[name] = version
      end
      result
    rescue
      nil
    end

    def code_package_installed?(package)
      extensions = code_installed_packages
      if extensions[package]
        # We have found the package, return the name
        package
      end
    rescue
      nil
    end

    def code_install_package(package)
      packages = code_installed_packages
      if packages[package]
        Chef::Log.info("Nothing to do, extension #{package} installed")
      else
        cmd = shell_out("#{interpreter} --install-extension #{package}")
        if cmd.stdout.include?('successfully installed')
          Chef::Log.info("#{package} installed")
        else
          Chef::Log.error("Error installing extension: #{package}")
        end

      end
    end

    def code_uninstall_package(package)
      packages = code_installed_packages
      if packages[package]
        cmd = shell_out("#{interpreter} --uninstall-extension #{package}")
        if cmd.stdout.include?('successfully uninstalled')
          Chef::Log.info("#{package} uninstalled")
        else
          Chef::Log.error("Error uninstalling extension: #{package}")
        end
      else
        Chef::Log.info("Nothing to do, #{package} not installed")
      end
    end

    def code_upgrade_package(package)
      # We are unable to upgrade the package directly at the moment
      # See: https://github.com/Microsoft/vscode/issues/45072
      # and https://github.com/Microsoft/vscode/issues/56578
      # for now we will uninstall and reinstall and check version numbers
      packages = code_installed_packages
      if packages[package]
        previous_version = packages[package]
        code_uninstall_package(package)
        code_install_package(package)
        packages = code_installed_packages
        new_version = packages[package]
        if previous_version == new_version
          # packages match so we want to show as no converge
          nil
        else
          Chef::Log.info("#{package} upgraded")
          true
        end
      else
        Chef::Log.info("#{package} not installed, will no upgrade")
      end
    end
  end
end
