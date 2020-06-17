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
  has_many :sent_messages, foreign_key: "sender_id", class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: "recipient_id", class_name: "PrivateMessage"

  #follow
  #users that you are following followed_users followees, returns instance of users we are following
  has_many :followed_users, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followed_users, source: :followee

  #users that follow you following_users followers, returns instance of users following us
  has_many :following_users, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :following_users, source: :follower

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def create_money_pot
    MoneyPot.create(user_id: self.id, money: 50)
  end

  def follow(user_id)
    followed_users.create(followee_id: user_id)
  end

  def unfollow(user_id)
    Follow.find_by(followee_id: user_id).destroy
  end

  def followed_users?(user_id)
    followed_users.find_by(followee_id: user_id)
  end

  def followed_users_list(user_id)
     Follow.where(follower_id: user_id)
  end
end
