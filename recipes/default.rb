#
# Cookbook Name:: Task5
# Recipe:: default

gInstaller = "#{Chef::Config['file_cache_path']}\
Greenshot-INSTALLER-1.2.8.12-RELEASE.exe"

gIniFile = "#{Chef::Config['file_cache_path']}greenshot-defaults.ini"


cookbook_file gInstaller do
  source 'Greenshot-INSTALLER-1.2.8.12-RELEASE.exe'
  #not_if 'yum list | grep mysql57-community-release'
end

cookbook_file gIniFile do
  source 'greenshot-defaults.ini'
  #not_if 'yum list | grep mysql57-community-release'
end


#execute 'mysql community rpm installation' do
#  command "rpm -ivh #{comm_rpm}"
#  not_if 'yum list | grep mysql57-community-release'
#end

