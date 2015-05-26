$:.unshift '.'

require 'grape'
require 'json'
require_relative 'app/lib/organization.rb'
require_relative 'app/api/posts.rb'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :options, :put]
  end
end

run(News::API)
