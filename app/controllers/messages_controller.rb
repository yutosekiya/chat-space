class MessagesController < ApplicationController
  def index
    @messages = Message.order('id ASC')
  end

  def create
    Message.create(message_params)
  end

  private
  def message_params
    params.require(:message).permit(:text, :image).merge(params[:user_id, :group_id])
  end


end
