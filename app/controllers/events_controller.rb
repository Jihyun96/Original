class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @events = Event.all.order('created_at DESC').page(params[:page]).per(30)
  end

  def show
    
  end

  def new
    @event = Event.new
  end

  def create
    star = current_user.authority
    if star == true
      @event = current_user.event.new(event_params)
  
      if @event.save
        flash[:success] = 'Event が正常に投稿されました'
        redirect_to @event
      else
        flash.now[:danger] = 'Event が投稿されませんでした'
        render :new
      end
      
    else
      redirect_to :back
    end
  end

  def edit
  end

  def upadate
    if @event.update(event_params)
      flash[:success] = 'Event は正常に更新されました'
      redirect_to @event
    else
      flash.now[:danger] = 'Event は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @event.destroy

    flash[:success] = 'Event は正常に削除されました'
    redirect_to events_url
  end
  
  def followers
    @event = Event.find(params[:id])
    @users = @event.participate_user.page(params[:page]).per(30)
    counts(@event)
  end
  
  private

  # Strong Parameter
  def event_params
    params.require(:event).permit(:title, :image, :content, :deadline)
  end
  def correct_user
    @event = Event.find_by(id: params[:id])
    unless @event
      redirect_to event_url
    end
  end
end
