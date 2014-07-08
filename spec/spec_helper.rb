ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require_relative '../main'

include Rack::Test::Methods

def app
  Sinatra::Application
end

# I looked into including testing with minitest, but did not write 
# any tests. I need to learn more about testing. I have done only
# short courses in the basics of rspec.