command :'build' do |c|
  include DockerRails::Helper
  c.syntax = "docker-rails build [service] [service] ..."
  c.summary = "Build services"
  c.description = "Build docker image from service configuration"

  c.action do |args, options|
    each_service(args) do |service_name, config|
      puts "-- building service: #{service_name}"
      File.open("Dockerfile", 'w') {|f| f.write(config["build"].join("\n"))}
      Docker::Image.build_from_dir(".", "t" => config["image"]) do |event|
        puts "#{JSON.parse(event)["stream"]}" if options.verbose
      end
      FileUtils.rm("Dockerfile")
    end
  end
  
end
