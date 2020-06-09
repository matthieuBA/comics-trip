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

conditions = ["parfait", "moyen", "médiocre", "passable"]
sell = ["vendable", "commenté", "recherché"]
pictures = ["https://www.bedetheque.com/media/Couvertures/kaamelott01.jpg",
"https://www.bedetheque.com/media/Couvertures/kaamelott02.jpg",
"https://www.bedetheque.com/media/Couvertures/kaamelot03_80683.jpg",
"https://www.bedetheque.com/media/Couvertures/KAAMELOTT_04_98245.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_118522.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_146768.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_189466.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_318330.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_392758.jpg",
"https://www.bedetheque.com/media/Couvertures/Kaarib01_20012002.jpg",
"https://www.bedetheque.com/media/Couvertures/kaarib2.JPG",
"https://www.bedetheque.com/media/Couvertures/Kaarib3_18112004.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395811.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395812.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395813.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395814.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395815.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395816.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395817.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395818.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395819.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395820.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395821.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395822.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395823.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395824.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395825.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395826.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395827.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395828.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395829.jpg",
"https://www.bedetheque.com/media/Couvertures/Couv_395830.jpg"]

20.times do |i|
  u=User.create(password:"not_blank",email:Faker::Internet.email)
  b=Book.create(title:Faker::DcComics.title, author:Faker::Book.author, genre:Faker::Book.genre, isbn:Faker::Code.isbn, picture:"https://www.bedetheque.com/media/Couvertures/Couv_3958"+(i+10).to_s+".jpg", abstract:Faker::Quote.yoda, extract:Faker::Quote.famous_last_words)
  p "https://www.bedetheque.com/media/Couvertures/Couv_3958"+(i+10).to_s+".jpg"
  bc=BookCard.create(user_id: User.all.sample.id, book_id: Book.all.sample.id, price: rand(100), to_sell: sell[rand(3)], book_condition: conditions[rand(3)], book_picture: "https://www.bedetheque.com/media/Couvertures/Couv_3958"+(i+10).to_s+".jpg", review:Faker::Quote.famous_last_words )
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
