class Admin::HomesController < ApplicationController

  def top
    @flyers = Flyer.all.order(id: :DESC).page(params[:page])
  end
end
