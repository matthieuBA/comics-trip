class UserMailer < ApplicationMailer

  default from: 'comics_trip_contact@yopmail.com'

  def welcome_email(user)

    @user = user

    @url = 'https://comics-trip.herokuapp.com/'

    mail(to: @user.email, subject: 'Bienvenue chez Comics trip !')
  end
end
