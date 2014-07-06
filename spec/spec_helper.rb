# I was not able to implement tests. But this is the start of my attempt. 
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require_relative '../main'

include Rack::Test::Methods

def app
  Sinatra::Application
end