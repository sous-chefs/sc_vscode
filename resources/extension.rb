property :extension_name, String, name_property: true

include Vscode::Helper

default_action :install

action :install do
  if code_package_installed?(new_resource.extension_name)
    converge_required = code_upgrade_package(new_resource.extension_name)
    if converge_required
      # Mark as converged, but do nothing as code_upgrade_package did the converge
      converge_by("Upgrading #{new_resource.extension_name}") do
      end
    end
  else
    converge_by("Installing #{new_resource.extension_name}") do
      code_install_package(new_resource.extension_name)
    end
  end
end

action :uninstall do
  if code_package_installed?(new_resource.extension_name)
    converge_by("Uninstalling #{new_resource.extension_name}") do
      code_uninstall_package(new_resource.extension_name)
    end
  end
end
