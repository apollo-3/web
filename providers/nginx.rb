use_inline_resources

action :install_server do
  template '/etc/yum.repos.d/nginx.repo' do
    source 'nginx.repo.erb'
    variables({:os => node['platform_family'], :release => node['platform_version'].to_i})
  end
  
  package 'nginx' do
    notifies :enable, 'service[nginx]', :immediately
    notifies :start, 'service[nginx]', :immediately
  end

  service 'nginx' do
    action :nothing
  end
  
end

action :load_balancer do
  ruby_block "Rename file" do
    block do
      ::File.rename('/etc/nginx/conf.d/default.conf','/etc/nginx/conf.d/default.conf.back')
    end
    only_if { ::File.file? "/etc/nginx/conf.d/default.conf" }
  end

  servers = []
  search(:node,'server_type:tomcat_app').each do |item|
    ip = item[:network][:interfaces][:enp0s8][:addresses].detect do |key, hash| 
      hash[:family] == 'inet'
    end
    servers.push ip.first
  end
            
  template '/etc/nginx/conf.d/lb.conf' do
    source 'lb.conf.erb'
    variables({:servers => servers})
    notifies :restart, 'service[nginx]', :immediately
  end
  
  service 'nginx' do
    action :nothing
  end
end

action :setup_web_server do
    action_restart
end

action :stop do
  service 'nginx' do
    action :stop
  end
end

action :start do
  service 'nginx' do
    action :start
  end
end

action :restart do
  service 'nginx' do
    action :restart
  end
end

action :reload do
  service 'nginx' do
    action :reload
  end
end