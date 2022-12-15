class Public::ClipsController < ApplicationController
  # 基本的にはいいねと同じ
  def create
    flyer = Flyer.find(params[:flyer_id])
    @clip = current_user.clips.new(flyer_id: flyer.id)
    @clip.save
    render "replace_btn"
  end

  def destroy
    flyer = Flyer.find(params[:flyer_id])
    @clip = current_user.clips.find_by(flyer_id: flyer.id)
    @clip.destroy
    render "replace_btn"
  end
end
