class UserMailer < ApplicationMailer

  default from: 'comics.trip.contact@gmail.com'

  def welcome_email(user)

    @user = user

    @url = 'https://comics-trip.herokuapp.com/'

    mail(to: @user.email, subject: 'Bienvenue chez Comics trip !')
  end
end
