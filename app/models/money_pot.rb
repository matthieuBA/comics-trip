class MoneyPot < ApplicationRecord
  belongs_to :user

  def self.buy(book_card, buyer, seller, buyer_money_pot, seller_money_pot)
    buyer_money_pot.money -= book_card.price
    buyer_money_pot.save
    seller_money_pot.money += book_card.price
    seller_money_pot.save

    BookCard.find(book_card.id).delete

    UserMailer.order_email_buyer(buyer, buyer_money_pot).deliver_now
    UserMailer.order_email_seller(seller, seller_money_pot).deliver_now
  end

  def self.add_money(user, amount)
    money_pot = user.money_pot

    money_pot.money += amount
    money_pot.save
  end
end
