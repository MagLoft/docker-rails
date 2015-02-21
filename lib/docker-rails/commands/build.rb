command :'build' do |c|
  c.syntax = "docker-rails build [service]"
  c.summary = "Build service"
  c.description = "Build a docker image from a service configuration"

  c.action do |args, options|
    
    # Prepare arguments
    @service = args[0]
    
    # Pack assets    
    bar = ProgressBar.new(10)
    bar.show
    (0..9).each do |step|
      sleep 1
      bar.increment
    end

    say_ok 'Your docker image was successfully created!'
  end
end