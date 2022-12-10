class Admin::HomesController < ApplicationController

  def top
    @flyers = Flyer.all.order(id: :DESC)
  end
end
