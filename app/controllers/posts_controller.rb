require 'pry'
require 'rack-flash'
class PostsController < ApplicationController
	 use Rack::Flash
	get '/posts' do
		if logged_in?
			@posts = Post.all
			erb :'users/homepage'
		else
			redirect to '/login'
		end
	end

	 get '/create_post' do
		if logged_in?
    	erb :'posts/create_post'
		else
			redirect '/login'
		end
  end


	post '/posts' do
		if params[:content].empty?
			flash[:message] = "Oops, you left the text box empty!"
			redirect '/posts/create_post'
		else
			@user = User.find(session[:user_id])
			@post = Post.create(:content => params[:content], :state=> params[:state], :user_id => @user.id)
			flash[:message] = "Your post has been successfully created!"
			redirect '/users/homepage'
		end
	end

	get '/users/homepage' do
		@posts = Post.all
		erb :'/users/homepage'
	end

	get '/edit_post' do
    if session[:user_id]
      @posts = User.find(session[:user_id]).posts
      erb :'posts/show'
    else
      redirect to '/login'
    end
  end

	get '/posts/:id/edit' do
		if session[:user_id]
			@post = Post.all.find_by_id(params[:id])
			erb :'posts/edit'
		else
			redirect to '/login'
		end
	end

	get '/posts/:id' do
		if session[:user_id]
	      @posts = User.find(session[:user_id]).posts
	      erb :'/posts/show'
	    else
	      redirect to '/login'
	    end
	  end

	patch '/posts/:id' do
     if params[:content].empty?
			 flash[:message] = "Oops, you left the text box empty!"
       redirect to "/posts/#{params[:id]}/edit"
     else
       @post = Post.find_by_id(params[:id])
       @post.content = params[:content]
       @post.save
			 flash[:message] = "Your post has been updated!"
       redirect to "/posts/#{@post.id}"
     end
   end

	 get '/posts/:id/delete' do
		 @post = Post.find_by_id(params[:id])
		 erb :'/posts/delete'
	 end

	 delete '/posts/:id/delete' do
		 @post = Post.find_by_id(params[:id])
		 if session[:user_id]
			 @post = Post.find_by_id(params[:id])
			 if @post.user_id == session[:user_id].to_s
				@post.delete
				flash[:message] = "Your post has been deleted!"
				redirect '/posts'
			 else
				 flash[:message] = "Please log in"
				 redirect '/login'
			 end
		 end
	 end



end
