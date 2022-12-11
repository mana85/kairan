class Public::UsersController < ApplicationController
  def show
    # 自分のページとしての表示と他のユーザーの詳細表示の出し分けをする
    if request.fullpath == "/users/my_page"
      @is_profile = false
      # 新着の告知
      @flyers = Flyer.all.order(id: :DESC)
      # アラートを出している告知をピックアップする
      today = Date.today
      @alert_flyers = Flyer.where(id: current_user.clips.where(is_alert: false).pluck(:flyer_id)).where(is_deleted: false).where("alert_date <= ?", today)
    else
      @is_profile = true
      @user = User.find(params[:id])
      @flyers = Flyer.where(user_id: @user)
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to request.referer
  end

  def unsubscribe
  end

  def withdrawal
    @user = current_user
    Flyer.where(user_id: @user.id).update_all(is_deleted: true)
    Comment.where(user_id: @user.id).update_all(is_deleted: true)
    @user.update(is_delete:true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :description, :profile_image, :url)
  end
end
