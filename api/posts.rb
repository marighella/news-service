module News
  class API < Grape::API
    version 'v1', using: :header, vendor: 'marighella'
    format :json

    resource :organization do
      desc 'Return a list of all posts'
      params do
        requires :organization, type: String, desc: 'Work with this organization'
      end
      get ':organization/posts' do
        Organization.get.posts
      end
    end
  end
end
