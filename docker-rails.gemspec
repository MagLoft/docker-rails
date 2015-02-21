# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docker-rails/version'

Gem::Specification.new do |s|
  s.name        = "docker-rails"
  s.version     = DockerRails::VERSION
  s.licenses    = ["BSD-3-Clause"]
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tobias Strebitzer"]
  s.email       = ["tobias.strebitzer@magloft.com"]
  s.homepage    = "http://www.magloft.com"
  s.summary     = "Docker tools for rails applications."
  s.description = "This gem allows you to setup a comprehensive docker/rails environment."
  s.required_rubygems_version = '>= 1.3.6'
  s.add_dependency "commander", '~> 4.1'
  s.add_dependency 'docker', '~> 0.0.1'
  s.add_dependency 'docker-api', '~> 1.19'
  s.add_development_dependency "rake", '~> 10.0'
  s.add_development_dependency "pry", '~> 0.10.1'
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_path = 'lib'
end
