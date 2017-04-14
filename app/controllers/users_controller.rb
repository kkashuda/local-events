class UsersController < ApplicationController
  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/homepage'
    end
  end

  

end
