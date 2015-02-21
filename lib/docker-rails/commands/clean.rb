command :'clean' do |c|
  include DockerRails::Helper
  c.syntax = "docker-rails clean"
  c.summary = "Clean up docker"
  c.description = "Delete stopped containers and orphaned images without tags"
  global_option('-i', '--images', 'Delete orphaned images')

  c.action do |args, options|
    
    # delete containers
    Docker::Container.all(:all => true).each do |container|
      if container.json["State"]["Running"] == false
        container.delete()
        print_item("container #{container.id} deleted")
      end
    end
  
    # delete images
    if options.images
      Docker::Image.find_by_tag("<none>:<none>").each do |image|
        image.remove(:force => true)
        print_item("imate #{image.id} deleted")
      end
    end
    
  end
end
