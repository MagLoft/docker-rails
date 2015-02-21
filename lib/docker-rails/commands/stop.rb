command :'stop' do |c|
  include DockerRails::Helper
  c.syntax = "docker-rails stop [service] [service] ..."
  c.summary = "Stop services"
  c.description = "Stop docker containers from service configuration"

  c.action do |args, options|
    each_service(args) do |service_name, config|
      if Docker::Container.stop(service_name)
        print_item("container stopped: #{service_name}")
      else
        print_item("container not running: #{service_name}")
      end
    end
  end
end
