require 'sinatra'
require 'data_mapper'

DataMapper.setup(
  :default,
  'mysql://root@localhost/superheroes'  
)

class Superhero
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :superpower1, Text
  property :superpower2, Text
  property :superpower3, Text
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @superheroes = Superhero.all
  erb :root
end

get '/create_superhero' do
  erb :create_superhero
end

post '/create_superhero' do
  puts params
  superhero = Superhero.new
  superhero.name = params[:superhero][:name]
  superhero.superpower1 = params[:superpowers][:superpower1]
  superhero.superpower2 = params[:superpowers][:superpower2]
  superhero.superpower3 = params[:superpowers][:superpower3]
  superhero.save

  redirect to("/")
end

get '/edit_superhero/:id' do
  @superhero = Superhero.get params[:id]
  erb :edit_superhero
end

put '/edit_superhero/:id' do
  @superhero = Superhero.get params[:id]
  @superhero.update params[:superhero]
  redirect to('/')
end





