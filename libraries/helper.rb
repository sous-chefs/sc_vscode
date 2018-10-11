#
# Author:: Xorima
# Cookbook:: vscode
# Library:: vscode_helper
#
# Copyright:: 2018, Sous-Chefs
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

    def code_installer_name
      case node['os']
      when 'linux'
        'code'
      else
        'vscode'
      end
    end

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

    def code_installed_packages(user)
      cmd = Mixlib::ShellOut.new("#{interpreter} --list-extensions --show-versions", :user => user)
      cmdres = cmd.run_command
      extensions = cmdres.stdout.split("\n")
      result = {}
      extensions.each do |e|
        info = e.split('@')
        name = info[0].downcase
        version = info[1]
        result[name] = version
      end
      result
    rescue
      nil
    end

    def code_package_installed?(package, user)
      extensions = code_installed_packages(user)
      if extensions[package.downcase]
        # We have found the package, return the name
        true
      else
        false
      end
    rescue
      nil
    end

    def code_install_package(package, user)
      installed = code_package_installed?(package, user)
      Chef::Log.error(installed)
      if installed
        Chef::Log.info("Nothing to do, extension #{package} installed")
      else
        cmd = Mixlib::ShellOut.new("#{interpreter} --install-extension #{package}", :user => user)
        cmdres = cmd.run_command
        Chef::Log.error("#{interpreter} --install-extension #{package} user= #{user}")
        Chef::Log.error(cmdres.stdout.to_s)
        if cmdres.stdout.include?('successfully installed')
          Chef::Log.info("#{package} installed")
        else
          raise("Error installing extension: #{package} for #{user}")
        end
      end
    end

    def code_uninstall_package(package, user)
      installed = code_package_installed?(package, user)
      if installed
        cmd = Mixlib::ShellOut.new("#{interpreter} --uninstall-extension #{package}", :user => user)
        cmdres = cmd.run_command
        if cmdres.stdout.include?('successfully uninstalled')
          Chef::Log.info("#{package} uninstalled")
        else
          raise("Error uninstalling extension: #{package}")
        end
      else
        Chef::Log.info("Nothing to do, #{package} not installed")
      end
    end

    def code_upgrade_package(package, user)
      # We are unable to upgrade the package directly at the moment
      # See: https://github.com/Microsoft/vscode/issues/45072
      # and https://github.com/Microsoft/vscode/issues/56578
      # for now we will uninstall and reinstall and check version numbers
      packages = code_installed_packages(user)
      package = package.downcase
      if packages[package]
        previous_version = packages[package]
        code_uninstall_package(package)
        code_install_package(package)
        packages = code_installed_packages(user)
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
