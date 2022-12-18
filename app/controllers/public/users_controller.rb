class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  def show
    # 自分のページとしての表示と他のユーザーの詳細表示の出し分けをする
    if request.fullpath == "/users/my_page"
      @is_profile = false
      # 自分のページを表示するときはアラートのある告知と新着の告知を表示する
      @flyers = Flyer.all.order(id: :DESC).page(params[:page])
      # アラートを出している告知をピックアップ
      today = Date.today
      @alert_flyers = Flyer.where(id: current_user.clips.where(is_alert: false).pluck(:flyer_id)).where(is_deleted: false).where("alert_date <= ?", today)
    else
      # 他のユーザーのページとして表示するときはその人のプロフィールとその人の投稿を表示する
      @is_profile = true
      @user = User.find(params[:id])
      @flyers = Flyer.where(user_id: @user).page(params[:page])
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to users_my_page_path
  end

  def unsubscribe
  end

  def withdrawal
    @user = current_user
    Flyer.where(user_id: @user.id).update_all(is_deleted: true)
    Comment.where(user_id: @user.id).update_all(is_deleted: true)
    @user.update(is_delete: true)
    reset_session
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:display_name, :description, :profile_image, :url)
    end

    def ensure_guest_user
      @user = User.find(current_user.id)
      if @user.display_name == "guestuser"
        redirect_to user_path(current_user)
        flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end
