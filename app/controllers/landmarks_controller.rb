class LandmarksController < ApplicationController
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @titles
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do
    set_landmark
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    set_landmark
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    set_landmark.update(params[:landmark])
    redirect "/landmarks/#{@landmark.id}"
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    redirect "/landmarks/#{@landmark.id}"
  end

  private

  def set_landmark
    @landmark = Landmark.find(params[:id])
  end

end
