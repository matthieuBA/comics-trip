class MoneyPotsController < ApplicationController

  def edit
    @book_card = BookCard.find(params[:id])

    if @book_card.to_sell == "vendable"
      buy
    end
  end

  private

  def buy
    buyer = User.find(current_user.id)
    seller = User.find(@book_card.user_id)

    buyer_money_pot = MoneyPot.find_by(user_id: buyer.id)
    seller_money_pot = MoneyPot.find_by(user_id: seller.id)

    if buyer_money_pot.money >= @book_card.price
      buyer_money_pot.money -= @book_card.price
      buyer_money_pot.save
      seller_money_pot.money += @book_card.price
      seller_money_pot.save

      flash[:success] = "L'achat à bien été effectué"
      redirect_to book_cards_path
    else
      flash[:error] = "Vous n'avez pas assez d'argent sur votre cagnotte !"
      redirect_to book_card_path(@book_card.id)
    end
  end
end
