#
# Cookbook Name:: Task5
# Recipe:: default

#
# Installing Far Manager - just as handy tool to check the results of
# the later actions.

windows_package 'farmanager' do
  source 'http://www.farmanager.com/files/Far30b4774.x64.20160902.msi'
  checksum '15437b76c1735e101f0e674ea8defeb25dc9781d7b3224d77526a0937c63bbdd'
  installer_type :msi
end

#
# Install Greenshot

windows_package 'Greenshot 1.2.8.12' do
  action :install
  source 'https://github.com/greenshot/greenshot/releases/download/'\
'Greenshot-RELEASE-1.2.8.12/Greenshot-INSTALLER-1.2.8.12-RELEASE.exe'
  checksum 'd229d905bb8141f2cdf4c82899b66b437a5ed6a0beb3bdcf701fdb3416ac7d74'
  version '1.2.8.12'
  installer_type :inno
end

#
# Install RSAT Hyper-V PowerShell module

require 'mixlib/shellout'

ps_mod_cmd = Mixlib::ShellOut.new('powershell Get-Module -ListAvailable')
ps_mod_cmd.run_command

windows_feature 'Microsoft-Hyper-V-Management-PowerShell' do
  action :install
  all true
end
