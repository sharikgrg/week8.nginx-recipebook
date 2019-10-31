#
# Cookbook:: node5
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node5::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '16.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should install nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    it 'enables the nginx service' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'starts the nginx service' do
      expect(chef_run).to start_service 'nginx'
    end

    it 'should install nodejs from a recipe' do
      expect(chef_run).to include_recipe 'nodejs'
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to install_nodejs_npm 'pm2'
    end

    it 'should create proxy.conf template in /etc/nginx/sites-available/proxy.conf' do
      expect(chef_run).to create_template "/etc/nginx/sites-available/proxy.conf"
    end

    it 'should symlink sites-available to sites-enable' do
      expect(chef_run).to create_link "/etc/nginx/sites-enabled/proxy.conf"
    end

    it 'should delete the similink from the default config' do
      expect(chef_run).to delete_link "/etc/nginx/sites-enabled/default"
    end

    it 'runs apt get apt update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    it 'should create proxy.conf template in /etc/nginx/sites-available with port 3000' do
      expect(chef_run).to create_template("/etc/nginx/sites-available/proxy.conf").with_variables(proxy_port: 3000)
    end

    it 'should install mongodb from a recipe' do
      expect(chef_run).to include_recipe 'mongodb'
    end

  end
end
