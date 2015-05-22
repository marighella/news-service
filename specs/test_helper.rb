ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'pry'

require_relative '../api.rb'
include Rack::Test::Methods
