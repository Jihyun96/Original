class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @events = @user.participate_event.order('created_at DESC').page(params[:page]).per(30)
    @messages = @user.message.order('created_at DESC').page(params[:page]).per(30)
    @count_events = @user.participate_event.count
    @count_messages = @user.message.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    @events = @user.participate_event.order('created_at DESC').page(params[:page]).per(10)
    @messages = @user.message.order('created_at DESC').page(params[:page]).per(10)
 
    if current_user == @user
   
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :show
      end   
     
    else
        redirect_to root_url
    end
  end
  
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :campus, :department, :grade, :password, :password_confirmation, :image, :image_cache)
  end
end
