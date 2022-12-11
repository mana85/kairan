class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.is_delete
      @user.update(is_delete: false)
    else
      Flyer.where(user_id: @user.id).update_all(is_deleted: true)
      Comment.where(user_id: @user.id).update_all(is_deleted: true)
      @user.update(is_delete: true)
    end
    redirect_to request.referer
  end
end
