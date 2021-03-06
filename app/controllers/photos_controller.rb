class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :like, :unlike] 
  before_action :owned_photo, only: [:edit, :update, :destroy] 

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photos = Photo.all
  end

  # GET /photos/new
  def new
    @photo = current_user.photos.build
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
     
    @photo = current_user.photos.build(photo_params)
     
    if @photo.save
      flash[:success] = "Your photo has been created!"
      redirect_to photos_path
    else
      flash[:alert] = "Your new photo couldn't be created! Please check the form."
      render :new
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def like  
    if @photo.liked_by current_user
        respond_to do |format|
          format.html { redirect_to :back }
          format.js { render 'photos/liking/like.js.erb' }
        end
    end
  end  
  
  def unlike  
    if @photo.unliked_by current_user
        respond_to do |format|
          format.html { redirect_to :back }
          format.js { render 'photos/liking/unlike.js.erb' }
        end
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:caption, :picture, :user_id)
    end
    
    # to avoid dit and delete other people’s photos
    def owned_photo 
      unless current_user == @photo.user
        flash[:alert] = "That photo doesn't belong to you!"
        redirect_to root_path
      end
    end
    
end
