module News
  class API < Grape::API
    version 'v1', using: :header, vendor: 'marighella'
    format :json

    resource :organization do
      params do
        requires :organization, type: String, desc: 'Wich organization I need get the information?'
        requires :repository, type: String, desc: 'Okay, I need know too the repository ( database? )'
      end


      desc 'Return a list of posts filtered by year and month'
      get ':organization/:repository/posts' do
        access_token = headers['Authorization'].split[1] if headers['Authorization']

        Organization.get(params[:organization], params[:repository], access_token).posts(params)
      end

      desc 'Return a complete post with body'
      get ':organization/:repository/posts/:id' do
        Organization.get(params[:organization], params[:repository]).post(params[:id])
      end
    end
  end
end
