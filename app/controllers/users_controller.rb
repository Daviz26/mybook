class UsersController < ApplicationController

    before_action :current_user, only: [:index, :edit, :update, :destroy]
    before_action :admin_user, only: :destroy
    
    def show
      @user = User.find_by(user_name: params[:user_name])
      @posts = @user.posts
      current_user.user_name == "You"
    end
    
    def index
      @users = User.paginate(page: params[:page])
    end
    
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end
    
    def following
      @title = "Following"
      @user = User.find_by(user_name: params[:user_name])
      @users = @user.following.paginate(page: params[:page])
      render 'users/following/show_following'
    end

    def followers
      @title = "Followers"
      @user = User.find_by(user_name: params[:user_name])
      @users = @user.followers.paginate(page: params[:page])
      render 'users/following/show_followers'
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end