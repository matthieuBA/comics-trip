class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # mailer "welcome"
  after_create :welcome_send, :create_money_pot

  has_many :book_cards
  has_many :books, through: :book_cards

  has_one :money_pot

  # mailer "welcome"
  after_create :welcome_send

  #private message
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def create_money_pot
    MoneyPot.create(user_id: self.id, money: 0)
  end
end
