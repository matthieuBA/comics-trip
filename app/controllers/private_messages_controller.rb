class PrivateMessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @send_messages = PrivateMessage.where(sender_id: current_user.id)
    @received_messages = PrivateMessage.where(recipient_id: current_user.id)
  end

  def show
    @message = PrivateMessage.find_by(id: params[:id])
  end

  def new
    if params[:format].nil?
      @private_message = PrivateMessage.new
    else
      if current_user.id == PrivateMessage.find(params[:format]).recipient_id
        @send_to = PrivateMessage.find(params[:format]).sender_id
      else
        @send_to = PrivateMessage.find(params[:format]).recipient_id
      end
      @private_message = PrivateMessage.new
    end
  end

  def create
    params[:private_message][:sender_id] = current_user.id
    @private_message = PrivateMessage.new(private_message_params)
    if @private_message.save
      flash[:success] = "Le message a été créé avec succès."
      redirect_to user_private_message_path(current_user.id, @private_message.id)
    else
      flash[:error] = @private_message.errors.messages
      render "new"
    end
  end

  def destroy
    @private_message = PrivateMessage.find(params[:id])
    @private_message.destroy
    redirect_to user_private_messages_path(current_user.id)
  end

  private

  def private_message_params
    params.require(:private_message).permit(:sender_id, :recipient_id, :content)
  end
end
