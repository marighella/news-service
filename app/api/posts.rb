module News
  class API < Grape::API
    version 'v1', using: :header, vendor: 'marighella'
    format :json

    resource :organization do
      params do
        requires :organization, type: String, desc: 'Work with this organization'
      end


      desc 'Return a list of posts filtered by year and month'
      get ':organization/:repository/posts' do
        Organization.get(params[:organization], params[:repository]).posts(params)
      end

      desc 'Return a complete post with body'
      get ':organization/:repository/posts/:id' do
        Organization.get(params[:organization], params[:repository]).post(params[:id])
      end
    end
  end
end
