$:.unshift '.'

require 'grape'
require 'json'
require_relative 'app/lib/organization.rb'
require_relative 'app/api/posts.rb'

run(News::API)
