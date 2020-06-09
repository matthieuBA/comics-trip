class BookCardsController < ApplicationController

  def show
    @book = Item.find_by(id: params[:id])
    unless current_user.nil?
    @cart = Cart.find_by(user_id: current_user.id)
    end
  end
end
