class UsersController < ApplicationController

    before_action :current_user, only: [:index, :edit, :update, :destroy]
    before_action :admin_user, only: :destroy
    
    def show
        @user = User.find(params[:id])
        #@microposts = @user.microposts.paginate(page: params[:page])
    end
    
    def index
        @users = User.paginate(page: params[:page])
    end
    
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User deleted"
        redirect_to users_url
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end