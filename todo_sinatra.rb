require 'sinatra'
require 'sinatra/activerecord'
set :database, 'sqlite:///todo_sinatra.db'

class Note < ActiveRecord::Base
  validates_uniqueness_of :content
  validates_presence_of :content
end

get '/' do
    #display all Notes in descending order by ID
    @notes = Note.all :order => :id
    erb :home
end

post '/' do  
  #create a new Note and save content to the database
  n = Note.new  
  n.content = params[:content]
  n.save  
  redirect '/'  
end

get '/:id/complete' do  
  @note = Note.find(params[:id]) 
  erb :complete  
end

delete '/:id' do  
  n = Note.find(params[:id]) 
  n.destroy  
  redirect '/'  
end