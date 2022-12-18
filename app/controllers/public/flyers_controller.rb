class Public::FlyersController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @flyer = Flyer.new
  end

  def show
    @flyer = Flyer.find(params[:id])
    @comment = Comment.new
    # リマインダーとしてアラートされた告知を閲覧したときだけクリップのアラート確認項目をTrueに更新する
    if params[:alert_check]
      current_user.clips.find_by(flyer_id: @flyer.id).update(is_alert: true)
    end
  end

  def index
    # 登録が新しい順から並べる
    @flyers = Flyer.all.order(id: :DESC).page(params[:page])
    @flyer = Flyer.new
  end

  def create
    @flyer = Flyer.new(flyer_params)
    @flyer.user_id = current_user.id
    tag_list = params[:flyer][:tag_name].split(",")
    if @flyer.save
      @flyer.save_tags(tag_list)
      flash[:notice] = "You have created flyer successfully!"
      redirect_to flyer_path(@flyer)
    else
      # @flyers = Flyer.all.order(id: :DESC)
      render "new"
    end
  end

  def edit
    @flyer = Flyer.find(params[:id])
    # 現在のタグを取得して表示する
    @tags = @flyer.tags.pluck(:tag_name).join(",")
  end

  def update
    tag_list = params[:flyer][:tag_name].split(",")
    if @flyer.update(flyer_params)
      @flyer.save_tags(tag_list)
      flash[:notice] = "You have updated flyer successfully!"
      redirect_to flyer_path(@flyer)
    else
      render "edit"
    end
  end

  def destroy
    @flyer.destroy
    redirect_to flyers_path
  end

  # クリップした告知を表示させる
  def clipedflyer
    cliped_flyers = Clip.where(user_id: current_user).pluck(:flyer_id)
    @flyers = Flyer.where(id: cliped_flyers).page(params[:page])
  end

  # 自分の投稿した告知を表示する
  def myflyer
    @flyers = Flyer.where(user_id: current_user).page(params[:page])
  end

  # タグ検索
  def tag
    @tag = Tag.find(params[:id])
    tag_flyers = FlyerTag.where(tag_id: params[:id]).pluck(:flyer_id)
    @flyers = Flyer.where(id: tag_flyers).page(params[:page])
  end

  # 検索は今回はGemで実装
  def search_word
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
