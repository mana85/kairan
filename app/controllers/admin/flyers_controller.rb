class Admin::FlyersController < ApplicationController
  def show
    @flyer = Flyer.find(params[:id])
  end

  def update
    @flyer = Flyer.find(params[:id])
    @flyer.update(is_deleted: true)
    redirect_to request.referer
  end
end
