require 'sinatra'
require_relative 'onfido'

set :port, 80
set :environment, :production

get '/applicant/:id/upload' do
  puts "uploading #{params[:id]}"
  token = env['HTTP_AUTHORIZATION']
  onFido = OnFido.new(token)
  onFido.upload_documents(params[:id])
end

get '/applicant/create' do
  token = env['HTTP_AUTHORIZATION']
  onFido = OnFido.new(token)
  onFido.create_applicant
end
