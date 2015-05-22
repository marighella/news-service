$:.unshift '.'

require 'grape'
require 'json'
require_relative 'lib/organization.rb'
require_relative 'api/posts.rb'

run(News::API)
