class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/create_users'
    else
      redirect 'users/homepage'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{@user.username}!"
      redirect to '/'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      #binding.pry
      erb :'/homepage'
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
      erb :'/users/homepage'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
