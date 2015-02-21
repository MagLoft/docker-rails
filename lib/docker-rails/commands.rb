$:.push File.expand_path('../', __FILE__)

global_option '--verbose'
require 'commands/status'
require 'commands/build'
require 'commands/start'
require 'commands/stop'
require 'commands/clean'
require 'commands/debug'
