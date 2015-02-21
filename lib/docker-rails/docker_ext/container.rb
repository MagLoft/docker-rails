module Docker
  
  class Container

    def self.spawn(name, opts, runopts={})
      begin
        container = Docker::Container.get(name, :all => true)
      rescue Exception => e
        opts["name"] = name
        container = Docker::Container.create(opts)
        puts "-- docker container #{name} created"
      end
      if container.info["State"] and container.info["Running"]
        puts "-- docker container #{name} is already running"
      else
        container.start(runopts)
        puts "-- docker container #{name} started"
      end
      container
    end
    
    def self.stop(name)
      begin
        container = Docker::Container.get(name, :all => true)
        if container.info["State"]["Running"]
          container.kill
          true
        else
          false
        end
      rescue Exception => e
        false
      end
    end
  
  end

end