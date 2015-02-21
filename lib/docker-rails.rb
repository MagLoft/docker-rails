require "docker-rails/version"
require 'yaml'
require 'docker'
#require 'docker-rails/docker_ext/container'
#require 'docker-rails/docker_ext/image'
require 'docker-rails/commands'

module DockerRails
  @@config = nil


  def self.config
    @@config = YAML.load_file("config/docker-rails.yml")  if not @@config
    @@config
  end

  def self.each_service(services, &block)
    services = config.keys if not services or services.length == 0
    services.each do |service_name|
      block.call(service_name, config[service_name])
    end
  end

end