# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Book.destroy_all

conditions = ["parfait", "moyen", "médiocre", "passable"]
sell = ["vendable", "commenté", "recherché"]

20.times do 
  u=User.create(password:"not_blank",email:Faker::Internet.email)
  b=Book.create(title:Faker::DcComics.title, author:Faker::Book.author, genre:Faker::Book.genre, isbn:Faker::Code.isbn, picture:"https://placekitten.com/800/#{rand(800..999)}", abstract:Faker::Quote.yoda, extract:Faker::Quote.famous_last_words)

  bc=BookCard.create(user_id: User.all.sample.id, book_id: Book.all.sample.id, price: rand(100), to_sell: sell[rand(3)], book_condition: conditions[rand(3)], book_picture: "https://placekitten.com/800/#{rand(800..999)}", review:Faker::Quote.famous_last_words )
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
