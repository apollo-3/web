web 'load_balancer' do
  provider Chef::Provider::WebNginx
  action :load_balancer
end