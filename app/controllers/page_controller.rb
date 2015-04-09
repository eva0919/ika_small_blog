class PageController < ApplicationController

	def index
		@posts = Post.paginate(:page => params[:page],:per_page => 30)
	end

end
