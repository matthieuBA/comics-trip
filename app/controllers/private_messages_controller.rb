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
    @private_message = PrivateMessage.new

  end

  def create
    puts "# "*100
    puts current_user.id
    puts "# "*100
    params[:private_message][:sender_id] = current_user.id
    @private_message = PrivateMessage.new(private_message_params)
      if @private_message.save
        flash[:success] = "Le message a été créé avec succès."
        redirect_to private_message_path(@private_message.id)
      else
        flash[:error] = @private_message.errors.messages
        render 'new'
      end
  end


  def destroy
    @private_message = PrivateMessage.find(params[:id])
    @private_message.destroy
    redirect_to private_messages_path
  end

private
  def private_message_params
    params.require(:private_message).permit(:sender_id, :recipient_id, :content)
  end
end
