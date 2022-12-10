class Public::UsersController < ApplicationController
  def show
    # 自分のページとしての表示と他のユーザーの詳細表示の出し分けをする
    if request.fullpath == "/users/my_page"
      @is_profile = false

      @flyers = Flyer.all.order(id: :DESC)
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
    @user.update(is_delete:true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :description, :profile_image, :url)
  end
end
