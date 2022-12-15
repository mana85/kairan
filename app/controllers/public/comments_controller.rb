class Public::CommentsController < ApplicationController
  def create
    flyer = Flyer.find(params[:flyer_id])
    @comment = current_user.comments.new(comment_params)
    @comment.flyer_id = flyer.id
    @comment.save
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], flyer_id: params[:flyer_id])
    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
