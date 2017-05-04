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
    @user = User.create(params)

    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = @user.errors.full_messages.join(", ")
      redirect to '/signup'
    else 
      if @user.save
        @user.save 
        session[:user_id] = @user.id
        flash[:message] = "Welcome! Thanks for signing up."
        redirect to '/'
      else 
        flash[:message] = @user.errors.full_messages.join(", ")
        redirect to '/signup'
      end
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      erb :'/users/homepage'
    end
  end

  post '/login' do
    user = User.create(params)
    if !params[:username].empty? && !params[:password].empty?
      user = User.find_by(username: params[:username])
    elsif params[:username].empty? 
      flash[:message] = user.errors.full_messages_for(:username).join
      redirect '/login'
    elsif params[:password].empty? 
      flash[:message] = "Password not valid"
      redirect '/login'
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect '/homepage'
    else
      flash[:message] = "Password not valid"
      redirect '/login'
    end
  end

  get '/homepage' do
    redirect '/login' if !logged_in? 
    @posts = Post.all
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
