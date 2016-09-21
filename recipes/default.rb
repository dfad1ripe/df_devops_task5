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

gInstaller = "#{Chef::Config['file_cache_path']}/\
Greenshot-INSTALLER-1.2.8.12-RELEASE.exe"

gIniFile = "#{Chef::Config['file_cache_path']}\greenshot-defaults.ini"

cookbook_file gInstaller do
  source 'Greenshot-INSTALLER-1.2.8.12-RELEASE.exe'
  not_if { File.exist?('C:\Program Files\Greenshot\Greenshot.exe') }
end

cookbook_file gIniFile do
  source 'greenshot-defaults.ini'
  not_if { File.exist?('C:\Program Files\Greenshot\Greenshot.exe') }
end

windows_package 'greenshot' do
  source gInstaller
  not_if { File.exist?('C:\Program Files\Greenshot\Greenshot.exe') }
end

file gInstaller do
  action :delete
end

file gIniFile do
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
  #not_if { File.exist?('C:\Program Files\Hyper-V\SnapInAbout.dll') }
end

# This requires a restart typically. We would not.
# but PowerShell commands would only work after the restart.

windows_service 'vmms' do
  action [:configure_startup, :start]
  startup_type :automatic
end
