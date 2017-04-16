class PostsController < ApplicationController 
	
	get '/posts' do 
		if logged_in?
			@posts = Post.all 
			erb :'users/homepage'
		else 
			redirect to '/login'
		end 
	end 

	 get '/create_post' do 
    erb :'posts/create_post'
  end 

  get "/posts/create_post" do 
    erb :'posts/create_post'
  end 


	post '/posts' do 
		if params[:content].empty? 
			redirect '/posts/create_post'
		else 
			@user = User.find(session[:user_id])
			@post = Post.create(:content => params[:content], :state=> params[:state], :user_id => @user.id)
			redirect '/users/homepage'
		end 
	end 
end 