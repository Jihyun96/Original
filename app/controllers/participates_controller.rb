class ParticipatesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    event = Event.find(params[:event_id])
    current_user.like(event)
    flash[:success] = '参加登録ありがとうございます。'
    redirect_to :back
  end

  def destroy
    event = Event.find(params[:event_id])
    current_user.unlike(event)
    flash[:success] = '残念です。またのご参加お待ちしてます。'
    redirect_to :back
  end
end
