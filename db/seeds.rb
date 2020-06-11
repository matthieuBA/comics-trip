# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Book.destroy_all
BookCard.destroy_all
Punch.destroy_all

conditions = ["parfait", "moyen", "médiocre", "passable"]
sell = ["vendable", "commenté", "recherché"]

50.times do |i|
  u=User.create(password:"not_blank",email:Faker::Internet.email)
  b=Book.create(title:Faker::DcComics.title, author:Faker::Book.author, genre:Faker::Book.genre, isbn:Faker::Code.isbn, picture:"https://www.bedetheque.com/media/Couvertures/Couv_3958"+(i+10).to_s+".jpg", abstract:Faker::Quote.yoda, extract:Faker::Quote.famous_last_words)
  p "https://www.bedetheque.com/media/Couvertures/Couv_3958"+(i+10).to_s+".jpg"
  bc=BookCard.create(user_id: User.all.sample.id, book_id: Book.all.sample.id, price: rand(100), to_sell: sell[rand(3)], book_condition: conditions[rand(3)], book_picture: "https://www.bedetheque.com/media/Couvertures/Couv_3958"+(i+10).to_s+".jpg", review:Faker::Quote.famous_last_words )
  p=Punch.create(punchable_id: BookCard.all.sample.id, punchable_type: "BookCard", starts_at: Time.zone.now, ends_at: Time.zone.now, average_time: Time.zone.now, hits: rand(10))
  p p.errors
end

# t.string "title"
# t.string "author"
# t.string "genre"
# t.string "isbn"
# t.string "picture"
# t.text "abstract"
# t.text "extract"


# t.bigint "user_id"
# t.bigint "book_id"
# t.decimal "price"
# t.string "to_sell"
# t.string "book_condition"
# t.string "book_picture"
# t.text "review"
