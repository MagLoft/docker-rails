command :'debug' do |c|
  include DockerRails::Helper
  c.syntax = "docker-rails debug [service]"
  c.summary = "Debug service"
  c.description = "Debug docker container by attaching to run"
  global_option('-f', '--force', 'Delete an existing container before running')

  c.action do |args, options|
    each_service(args) do |service_name, config|
      # delete container if exists
      container = Docker::Container.fetch(service_name)
      if container
        if options.force
          container.delete()
        else
          print_item("container already exists. use --force to delete", false)
          abort
        end
      end
      
      # invoke docker run
      links = config["links"] ? config["links"].map{|link| "--link #{link}"}.join(" ") : ""
      ports = config["ports"] ? config["ports"].map{|port| "-p #{port}:#{port}"}.join(" ") : ""
      result = system "docker run --name #{service_name} #{ports} #{links} -t -i #{config["image"]}"
      
      print_item("an error occured. did you build the image already?", false) if not result
    end
  end
end
