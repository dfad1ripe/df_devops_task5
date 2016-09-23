#
# Cookbook Name:: Task5
# Recipe:: default

#
# Installing Far Manager - just as handy tool to check the results of
# the later actions.

windows_package 'farmanager' do
  source 'http://www.farmanager.com/files/Far30b4774.x64.20160902.msi'
  installer_type :msi
  not_if '"C:/Program Files/Far Manager/Far.exe" /?'
end

#
# Install Greenshot

windows_package 'greenshot' do
  action :install
  source 'https://github.com/greenshot/greenshot/releases/download/'\
'Greenshot-RELEASE-1.2.8.12/Greenshot-INSTALLER-1.2.8.12-RELEASE.exe'
  # installer_type :inno
  not_if '"C:/Program Files/Greenshot/Greenshot.exe" /reload'
end

#
# Install RSAT Hyper-V PowerShell module

require 'mixlib/shellout'

ps_mod_cmd = Mixlib::ShellOut.new('powershell Get-Module -ListAvailable')
ps_mod_cmd.run_command

windows_feature 'Microsoft-Hyper-V-Management-PowerShell' do
  action :install
  all true
  not_if { ps_mod_cmd.stdout.include? 'Hyper-V' }
end

#
# We might want to install Hyper-V role to make the above some sence

# windows_feature 'Microsoft-Hyper-V' do
#   action :install
#   all true
# end

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
