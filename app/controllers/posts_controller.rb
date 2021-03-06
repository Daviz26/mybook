class PostsController < ApplicationController
    before_action :current_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
  
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
          flash[:success] = "post created!"
          redirect_to :back
        else
            @feed_items = []
            render 'welcome/profile'
        end
    end
    
    def destroy
        @post.destroy
        flash[:success] = "post deleted"
        redirect_to request.referrer || root_url
    end
    
    private
  
    def post_params
      params.require(:post).permit(:content, :picture)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
    
end
