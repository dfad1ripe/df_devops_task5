#
# Cookbook Name:: Task5
# Recipe:: default

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

windows_feature 'Microsoft-Hyper-V-Management-PowerShell' do
  action :install
  all true
end
