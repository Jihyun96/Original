class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = current_user.message.new(message_params)

    if @message.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end
  
  private

  # Strong Parameter
  def message_params
    params.require(:message).permit(:title, :content)
  end
  def correct_user
    @message = current_user.message.find_by(id: params[:id])
    unless @message
      redirect_to message_url
    end
  end

end
