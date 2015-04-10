class PageController < ApplicationController
	before_action :login_required, :only => [:new_post,:save_new_post]
	def index
		@posts = Post.paginate(:page => params[:page],:per_page => 15).order('created_at DESC')
	end

	def new_post
	end

	def view_post
		@post = Post.find(params[:id])
		@title = @post.title
		@context = @post.context.split("\n")
	end

	def save_new_post
		@post = Post.new
		@post.title = params[:title]
		@post.context = params[:context]
		@post.user_id = current_user.id
		@post.save
		redirect_to :root
	end

	def edit_post
		@post = Post.find(params[:id])
		unless current_user && current_user.id == @post.user_id
			redirect_to :root
		end
	end

	def save_edit_post
		@post = Post.find(params[:id])
		if current_user && current_user.id == @post.user_id
			@post.title = params[:title]
			@post.context = params[:context]
			@post.save
		end
		redirect_to :root
	end


	def delete_post
		@post = Post.find(params[:id])
		if current_user && current_user.id == @post.user_id
			@post.destroy
		end
		redirect_to :root
	end



	def login_required
		if current_user.blank?
			respond_to do |format|
				format.html {
					authenticate_user!
				}
				format.js {
					render :partial => "common/not_logined"
				}
				format.all {
					head(:unauthorized)
				}
			end
		end
	end

end
