require "docker-rails/version"
require 'yaml'
require 'docker'
require 'docker-rails/docker_ext/container'
require 'docker-rails/docker_ext/image'
require 'docker-rails/helper'

# increase read timeout
Docker.options[:read_timeout] = 3600

module DockerRails
  @@config = nil

  def self.config
    return @@config if @@config
    @@config = File.exists?("config/docker-rails.yml") ? YAML.load_file("config/docker-rails.yml") : {}
    @@config
  end

end