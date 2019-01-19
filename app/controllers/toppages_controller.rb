class ToppagesController < ApplicationController
  def index
    @events = Event.all.order('created_at DESC').page(params[:page]).per(30)
  end
end
