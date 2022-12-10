class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?

  private


  # 検索にransackを使用してみる
  def set_search
    @q = Flyer.ransack(params[:q])
    # @flyers = @q.result(distinct: true).page(params[:page]).per(8)
    @flyers = @q.result.order(created_at: :DESC)
  end
  #   ransackメソッドは検索ヘルパーメソッドである
  # resultメソッドは検索結果を返すヘルパーメソッドである
  # distinct: trueは、重複する検索結果を除外する役割を持つ


  protected

    # 新規登録時の項目カスタム対応
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :description, :url, :is_delete])
    end

end
