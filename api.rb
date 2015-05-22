require 'grape'
require 'json'


module News
  class API < Grape::API
    version 'v1', using: :header, vendor: 'marighella'
    format :json

    resource :organization do
      desc 'Return a list of all posts'
      get :posts do
        @posts = [{ name: 'p1'
        },
        {
          name: 'p2'
        }
        ]

        @posts
      end
    end
  end
end
