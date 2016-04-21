require 'sinatra'
require 'pry'
require 'json'

class Message
	attr_reader :messages

	def initialize(messages)
		@messages = {"Valid" => true, "Info": "IDX10214: Audience validation failed. Audiences: 'http://localhost:1337/'. Did not match:  validationParameters.ValidAudience: 'null' or validationParameters.ValidAudiences: 'https://www.servsmart.servicemaster.com, http://mem0bscweb01d:60/, http://localhost:1337'"}
	end

	def to_json(options = {})
		@messages.to_json(options)
	end
end

class Rejection
	attr_reader :rejection

	def initialize(rejection)
		@rejection = {"Valid" => false, "Info": "IDX10214: Audience validation failed. Audiences: 'http://localhost:1337/'. Did not match:  validationParameters.ValidAudience: 'null' or validationParameters.ValidAudiences: 'https://www.servsmart.servicemaster.com, http://mem0bscweb01d:60/, http://localhost:1337'"}
	end

	def to_json(options = {})
		@rejection.to_json(options)
	end
end

messages = Message.new(messages)
rejection = Rejection.new(rejection)

before do
  content_type :json
end


configure :development do
  set :show_exceptions, :after_handler
end

not_found do
  { message: 'Not Found', code: 404 }.to_json
end

error do
  { message: env['sinatra.error'], code: 500 }.to_json
end

get '/validate-auth-header' do
	if request.env['HTTP_AUTHORIZE']
		response.body = messages.to_json
	else
		response.body = rejection.to_json
		halt 401
	end
end

