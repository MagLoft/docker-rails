command :'status' do |c|
  c.syntax = "docker-rails status [service] [service] ..."
  c.summary = "Show services status"
  c.description = "Show status (build, image, container) about configured services"

  c.action do |args, options|
    DockerRails.each_service(args) do |service_name, config|
      image = Docker::Image.find_one_by_tag("#{config["image"]}:latest")
      begin
        container = Docker::Container.get(container_name, :all => true)
      rescue Exception => e
        container = nil
      end
      puts "#{container_name}:"
      puts status_item("image exists", !!image)
      puts status_item("container exists", !!container)
      puts status_item("container running", (not container.nil? and container.info["State"]["Running"]))
    end
  end
  
  def print_item(message, completed=true)
    icon = completed ? '✓' : '×'
    message = " #{icon} #{message}"
    (completed ? say_ok(message) : say_error(message))
  end
  
end
