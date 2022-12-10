class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :alert_flyer

  private

  def alert_flyer
    # ログインユーザーがページトップを表示した場合にアラートのチェックをする
    if user_signed_in?
      today = Date.today
      # アラートフラグのない今日以前にアラート設定のあるフライヤーの数を取得
      check_flyer = current_user.clips.where(is_alert: false).pluck(:flyer_id)
      p current_user.clips.where(is_alert: false).pluck(:flyer_id)
      p Flyer.where(id: check_flyer, is_deleted: false).count
      current_user.clips.each do |fl|
        # p fl.flyers.title
      end
      # p current_user.clips.joins(:flyers)
      p "↑データみたいね"

      @alert = current_user.clips.where(is_alert: false).joins(:flyer).where("alert_date <= ?", today).count
    end
  end


  # 検索にransackを使用してみる
  def set_search
    @q = Flyer.ransack(params[:q])
    # @flyers = @q.result(distinct: true).page(params[:page]).per(8)
    @flyers = @q.result.order(created_at: :DESC)
  end

  protected

    # 新規登録時の項目カスタム対応
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :description, :url, :is_delete])
    end

end
