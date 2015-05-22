require 'grape'
require 'json'
require_relative 'lib/organization.rb'


module News
  class API < Grape::API
    version 'v1', using: :header, vendor: 'marighella'
    format :json

    resource :organization do
      desc 'Return a list of all posts'
      get :posts do
        Organization.get.posts
      end
    end
  end
end
