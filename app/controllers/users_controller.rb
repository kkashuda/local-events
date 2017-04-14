class UsersController < ApplicationController
  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/homepage'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :create_user
    else
      redirect '/homepage'
    end
  end

  post '/signup' do
  end

  post 'login' do
    if !params[:username].empty? && !params[:password].empty?
      user = User.find(params[:username])
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/homepage'
    else
      redirect '/signup'
    end



end
