require 'sinatra'
require 'pry'


before do
  content_type :json
end

get '/validate-auth-header' do
	{
		"Valid": true,
		"Info": "IDX10214: Audience validation failed. Audiences: 'http://localhost:1337/'. Did not match:  validationParameters.ValidAudience: 'null' or validationParameters.ValidAudiences: 'https://www.servsmart.servicemaster.com, http://mem0bscweb01d:60/, http://localhost:1337'"
	}
end

