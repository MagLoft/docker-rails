command :'status' do |c|
  include DockerRails::Helper
  c.syntax = "docker-rails status [service] [service] ..."
  c.summary = "Show services status"
  c.description = "Show status (build, image, container) about configured services"

  c.action do |args, options|
    each_service(args) do |service_name, config|
      image = Docker::Image.find_one_by_tag("#{config["image"]}:latest")
      container = Docker::Container.fetch(service_name)
      puts "#{service_name}:"
      print_item("image exists", !!image)
      print_item("container exists", !!container)
      print_item("container running", (not container.nil? and container.info["State"]["Running"]))
    end
  end
end
