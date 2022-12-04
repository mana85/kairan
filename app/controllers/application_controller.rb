class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 新規登録時の項目カスタム対応
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :description, :url])
  end
end
