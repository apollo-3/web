use_inline_resources

action :install_server do
  package 'httpd'
  # this is where use_inline_resources do their magic,
  # letting know :install_server that it has to be updated, due to
  # service 'httpd' enable and start action update
  action_enable
  action_start
end

action :setup_web_server do
end

action :stop do
  service 'httpd' do
    action :stop
  end
end

action :start do
  service 'httpd' do
    action :start
  end
end

action :restart do
  service 'httpd' do
    action :restart
  end
end

action :reload do
  service 'httpd' do
    action :reload
  end
end