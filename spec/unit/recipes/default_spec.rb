#
# Cookbook Name:: Task5
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper.rb'

describe 'Task5::default' do
  context 'test:' do

    before (:each) do
      stub_command(/Far.exe/).and_return(true)
      stub_command(/Greenshot.exe/).and_return(true)
    end

    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012r2')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs "Greenshot"' do
      expect(chef_run).to install_windows_package('greenshot')
    end

    it 'installs Hyper-V PS module' do
      expect(chef_run).to install_windows_feature('Microsoft-Hyper-V-Management-PowerShell')
    end
  end
end
