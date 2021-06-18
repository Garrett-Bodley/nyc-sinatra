class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    # @landmarks = Landmark.all.select{|landmark| landmark.figure == nil}
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = current_figure
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = current_figure
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  patch '/figures/:id'do
    @figure = current_figure
    @figure.update(params[:figure])
    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
      @figure.titles << @title
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
    end
    redirect "/figures/#{@figure.id}"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
      @figure.titles << @title
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
    end
    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    @figure = current_figure
    @figure.titles.each{|title| title.figures.delete(@figure)}
    @figure.landmarks.each{|landmark| landmark.figure = nil}
    current_figure.destroy
    redirect '/figures'
  end

  helpers do
    def current_figure
      Figure.find(params[:id])
    end
  end

end
