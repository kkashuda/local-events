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


end
