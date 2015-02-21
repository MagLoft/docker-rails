module DockerRails
  module Helper

    def each_service(services, &block)
      services = DockerRails.config.keys if not services or services.length == 0
      services.each do |service_name|
        block.call(service_name, DockerRails.config[service_name])
      end
    end

    def print_item(message, completed=true)
      icon = completed ? '✓' : '×'
      message = " #{icon} #{message}"
      (completed ? say_ok(message) : say_error(message))
    end
    
    def get_runopts(config)
      runopts = {}
      if config["ports"]
        runopts["PortBindings"] = {}
        config["ports"].each do |port|
          runopts["PortBindings"]["#{port}/tcp"] = [{HostPort: port}]
        end
      end
      if config["links"]
        runopts["Links"] = config["links"]
      end
      runopts
    end
    
  end
end
