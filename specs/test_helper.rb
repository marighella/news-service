ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'pry'

require 'grape'
require 'json'
require_relative '../app/lib/organization.rb'
require_relative '../app/api/posts.rb'

include Rack::Test::Methods
