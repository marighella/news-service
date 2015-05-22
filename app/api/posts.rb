module News
  class API < Grape::API
    version 'v1', using: :header, vendor: 'marighella'
    format :json

    resource :organization do
      params do
        requires :organization, type: String, desc: 'Work with this organization'
      end


      desc 'Return a list of all posts'
      get ':organization/posts' do
        Organization.get(params[:organization]).posts
      end

      desc 'Return a complete post with body'
      get ':organization/posts/:id' do
        Organization.get(params[:organization]).posts(params[:id])
      end
    end
  end
end
