class CommentsController < ApplicationController
  before_action :set_photo

  def create 
    @comment = @photo.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
        
      respond_to do |format|
        format.html { redirect_to photo_path(@photo) }
        #format.js
      end
    else
       flash[:alert] = "Check the comment form, something went horribly wrong."
       render root_path
    end
  end
  

  def destroy 
    @comment = @photo.comments.find(params[:id])

    if @comment.user_id == current_user.id
        @comment.destroy

        respond_to do |format|
            format.html { redirect_to photo_path(@photo) }
            #format.js
        end
    end 
  end

 

  private

    def comment_params 
      params.require(:comment).permit(:content)
    end

    def set_photo 
      @photo = Photo.find(params[:photo_id])
    end
    
end
