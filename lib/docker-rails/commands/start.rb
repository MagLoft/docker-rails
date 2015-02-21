command :'start' do |c|
  include DockerRails::Helper
  c.syntax = "docker-rails start [service] [service] ..."
  c.summary = "Start services"
  c.description = "Start docker containers from service configuration"

  c.action do |args, options|
    each_service(args) do |service_name, config|
      result = Docker::Container.spawn(service_name, {"Image" => config["image"]}, get_runopts(config))
      print_item("container created: #{service_name}") if result[:created]
      if result[:started]
        print_item("container started: #{service_name}")
      else
        print_item("container already running: #{service_name}")
      end
    end
  end
end
