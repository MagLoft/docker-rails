module Docker
  class Container

    def self.spawn(name, opts, runopts={})
      result = {
        container: fetch(name),
        created: false,
        started: false
      }
      if result[:container].nil?
        opts["name"] = name
        result[:container] = Docker::Container.create(opts)
        result[:created] = true
      end
      if not result[:container].info["State"] or not result[:container].info["State"]["Running"]
        result[:container].start(runopts)
        result[:started] = true
      end
      result
    end
    
    def self.stop(name)
      container = fetch(name)      
      if container and container.info["State"]["Running"]
        container.kill
        true
      else
        false
      end
    end
    
    def self.fetch(container_name)
      begin
        Docker::Container.get(container_name, :all => true)
      rescue Exception => e
        nil
      end
    end
  
  end
end
