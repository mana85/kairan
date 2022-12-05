class Public::FlyersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @flyer = Flyer.find(params[:id])
    @flyer_comment = Comment.new
  end

  def index
    # 登録が新しい順から並べる
    @flyers = Flyer.all.order(id: :DESC)
    @flyer = Flyer.new
  end

  def create
    @flyer = Flyer.new(flyer_params)
    @flyer.user_id = current_user.id
    tag_list = params[:flyer][:tag_name].split(',')
    if @flyer.save
      @flyer.save_tags(tag_list)
      redirect_to "/"
      # redirect_to flyer_path(@flyer)
      # notice:"You have created flyer successfully!"
    else
      @flyers = Flyer.all.order(id: :DESC)
      render 'index'
    end
  end

  def edit
  end

  def update
    if @flyer.update(flyer_params)
      redirect_to flyer_path(@flyer)
      # notice: "You have updated book successfully!"
    else
      render "edit"
    end
  end

  def destroy
    @flyer.destroy
    redirect_to flyers_path
  end

  private

  def flyer_params
    params.require(:flyer).permit(:title, :body, :image, :banner, :url, :alert_date, :is_deleted)
  end

  def ensure_correct_user
    @flyer = Flyer.find(params[:id])
    unless @flyer.user == current_user
      redirect_to flyers_path
    end
  end
end
