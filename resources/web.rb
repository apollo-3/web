resource_name :web

actions :install_server, :setup_web_server, :stop, :start, :restart, :reload, :load_balancer

default_action :create

attribute :port, :kind_of => String, :default => '80'