ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'pry'

require 'grape'
require 'json'
require_relative '../lib/organization.rb'
require_relative '../api/posts.rb'

include Rack::Test::Methods
