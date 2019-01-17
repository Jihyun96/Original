class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @comment = current_user.comment.build(comments_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to :back
    else
      @comments = Message.find_by(id: params[:id]).comment.page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_to :back
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_to :back
  end
  
  private

  def comments_params
    params.require(:comment).permit(:content, :title, :message_id)
  end
  
  def correct_user
    @comment = current_user.comment.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
  
end
