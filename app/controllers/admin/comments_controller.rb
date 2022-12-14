class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all.page(params[:page])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(is_deleted: true)
    redirect_to request.referer
  end
end
