#
# Cookbook Name:: Task5
# Recipe:: default

#
# Installing Far Manager - just as handy tool to check the results of
# the later actions.

windows_package 'farmanager' do
  source 'http://www.farmanager.com/files/Far30b4774.x64.20160902.msi'
  installer_type :msi
  not_if { File.exist?('C:\Program Files\Far Manager\Far.exe') }
end

#
# Install Greenshot from local installer file.

g_installer = "#{Chef::Config['file_cache_path']}/\
Greenshot-INSTALLER-1.2.8.12-RELEASE.exe"

g_ini_file = "#{Chef::Config['file_cache_path']}\greenshot-defaults.ini"

cookbook_file g_installer do
  source 'Greenshot-INSTALLER-1.2.8.12-RELEASE.exe'
  not_if { File.exist?('C:\Program Files\Greenshot\Greenshot.exe') }
end

cookbook_file g_ini_file do
  source 'greenshot-defaults.ini'
  not_if { File.exist?('C:\Program Files\Greenshot\Greenshot.exe') }
end

windows_package 'greenshot' do
  source g_installer
  not_if { File.exist?('C:\Program Files\Greenshot\Greenshot.exe') }
end

file g_installer do
  action :delete
end

file g_ini_file do
  action :delete
end

#
# Install RSAT Hyper-V PowerShell module

windows_feature 'Microsoft-Hyper-V-Management-PowerShell' do
  action :install
  all true
  not_if { File.exist?('C:\Program Files\Hyper-V\SnapInAbout.dll') }
end

#
# Install Hyper-V role to make the above some sence

windows_feature 'Microsoft-Hyper-V' do
  action :install
  all true
end

# This requires a restart typically. We would not.
# but PowerShell commands would only work after the restart and
# starting vmms service as well, as below.

# windows_service 'vmms' do
#  action [:configure_startup, :start]
#  startup_type :automatic
# end

# we can initiate 'delayed' installation of this service by
# corresponding script, that would: a) restart the system in 5-10 min
# after the provisioning; and b) enable and start vmms service after
# the restart.
