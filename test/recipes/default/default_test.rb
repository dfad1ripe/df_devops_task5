# # encoding: utf-8

# Inspec test for recipe Task5::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe command('"C:\Program Files\Greenshot\Greenshot.exe" /reload') do
  its(:exit_status) { should eq 0 }
end

describe command('powershell Get-Module -ListAvailable') do
  its(:stdout) { should match 'Hyper-V' }
end
