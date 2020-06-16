class MoneyPotsController < ApplicationController

  def edit
    @book_card = BookCard.find(params[:id])

    if @book_card.to_sell == "vendable"
      buy
      redirect_to root_path
    end
  end

  private

  def buy
    buyer = User.find(current_user.id)
    seller = User.find(@book_card.user_id)

    buyer_money_pot = MoneyPot.find_by(user_id: buyer.id)
    seller_money_pot = MoneyPot.find_by(user_id: seller.id)

    buyer_money_pot.money -= @book_card.price
    buyer_money_pot.save
    seller_money_pot.money += @book_card.price
    seller_money_pot.save
  end
end
