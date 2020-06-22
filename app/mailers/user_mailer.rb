class UserMailer < ApplicationMailer
  default from: "comics.trip.thp@gmail.com"

  def welcome_email(user)
    @user = user

    @url = "https://comics-trip.herokuapp.com/"

    mail(to: @user.email, subject: "Bienvenue chez COMICS TRIP !")
  end

  def order_email_buyer(user, user_money_pot)
    @user = user
    @user_money_pot = user_money_pot

    @url = "https://comics-trip.herokuapp.com/"

    mail(to: @user.email, subject: "Vous venez d'acheter un livre !")
  end

  def order_email_seller(user, user_money_pot)
    @user = user
    @user_money_pot = user_money_pot

    @url = "https://comics-trip.herokuapp.com/"

    mail(to: @user.email, subject: "Vous venez de vendre un livre !")
  end
end
