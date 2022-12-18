class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :alert_flyer

  private
    def alert_flyer
      # ログインユーザーがページトップを表示した場合にアラートのチェックをする
      if user_signed_in?
        today = Date.today
        @alert = Flyer.where(id: current_user.clips.where(is_alert: false).pluck(:flyer_id)).where(is_deleted: false).where("alert_date <= ?", today).count
      end
    end


    # 検索にransackを使用する
    def set_search
      @q = Flyer.ransack(params[:q])
      # @flyers = @q.result(distinct: true).page(params[:page]).per(8)
      @flyers = @q.result.order(created_at: :DESC).page(params[:page])
    end

  protected
    # 新規登録時の項目カスタム対応
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :description, :url, :is_delete])
    end
end
