#
# Cookbook:: node5
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update 'update_sources' do
  action :update
end
# include_recipe 'apt'
package 'nginx'

# template 'destination' do
#   source 'name'
# end

service 'nginx' do
  action [:enable, :start]
end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables(proxy_port: node['nginx']['proxy_port'])
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  # notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end



include_recipe 'nodejs'
nodejs_npm 'pm2'
