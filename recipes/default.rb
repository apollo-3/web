#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

web 'install_web_server' do
  case node[:web_server_type]
  when 'web_apache'
    provider Chef::Provider::WebApache
  when 'web_nginx', 'load_balancer'
    provider Chef::Provider::WebNginx
  end
  action :install_server
end