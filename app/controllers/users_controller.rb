require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
   if !logged_in?
      erb :'users/new'
    else
      redirect 'users/homepage'
    end 
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Oops, please fill out all fields!"
      redirect to '/signup'
    else
      @user = User.create(params)
      @user.save
      current_user = @user.id
      flash[:message] = "Welcome! Thanks for signing up."
      redirect to '/'
    end
  end

  get '/login' do
     if !current_user
      erb :'/users/login'
    else
      #binding.pry
      erb :'/users/show'
    end
  end

  post '/login' do
    if !params[:username].empty? && !params[:password].empty?
      user = User.find_by(username: params[:username])
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/homepage'
    else
      redirect '/signup'
    end
  end

  get '/homepage' do
    if logged_in? 
      @posts = Post.all
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
