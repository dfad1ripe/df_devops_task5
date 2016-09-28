# # encoding: utf-8

# Inspec test for recipe Task5::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

require 'serverspec'
#require 'winrm'

set :backend, :winrm
set :os, :family => 'windows'

#
# Canonical test for Greenshot package that does not work.

describe package('Greenshot 1.2.8.12') do
  it { should be_installed }
end

#
# Alternative test for Greenshot package

#describe command('"C:\Program Files\Greenshot\Greenshot.exe" /reload') do
#  its(:exit_status) { should eq 0 }
#end

#
# Canonical test for Hyper-V PowerShell module

describe windows_feature('Hyper-V-PowerShell') do
  it{ should be_installed }
#  it{ should be_installed.by("dism") }
#  it{ should be_installed.by("powershell") }
end

#
# Alternative test for Hyper-V PowerShell module

#describe command('powershell Get-Module -ListAvailable') do
#  its(:stdout) { should match 'Hyper-V' }
#end
