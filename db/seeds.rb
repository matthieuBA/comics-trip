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
PrivateMessage.destroy_all

conditions = ["parfait", "moyen", "médiocre", "passable"]
sell = ["vendable", "commenté", "recherché"]
titles = ["Blacksad", "Astérix", "La quête de l'oiseau du temps", "XIII", "Gaston", "Tintin", "Thorgal", "Lanfeust de Troy", "Murena", "De Cape et de Crocs", "Largo Winch", "Peter Pan", "Spirou et Fantasio", "Blueberry", "Le combat ordinaire", "Universal War One", "Aldébaran", "Les passagers du vent", "Blake et Mortimer", "Lucky Luke", "Le grand pouvoir du Chninkel", "Le troisième Testament", "Le scorpion", "Idées noires Humour", "Sillage", "Djinn", "Long John Silver", "Maus", "Corto Maltese", "Le tueur", "Les tuniques Bleues", "Okko", "Soda", "Magasin général", "Le cycle de Cyann", "L'incal - Une aventure de John Difool", "Le retour à la terre", "Où le regard ne porte pas...", "Le sursis", "Calvin et Hobbes", "Sambre", "Complainte des Landes perdues Heroic", "Les 7 Vies de l'Épervier", "Nikopol", "Bételgeuse", "Garulfo", "Il était une fois en France", "Valérian", "Le décalogue", "Le chant des Stryges", "Jeremiah", "Rapaces ", "Bouncer", "Quartier", "Le vol du corbeau", "Alim le tanneur", "Le triangle Secret", "Chi", "Rubrique-à-Brac", "Watchmen", "L'Épervier", "Trolls de Troy", "Golden City", "Les compagnons du crépuscule", "Walking Dead", "La caste des Méta-Barons", "Donjon Zénith", "Les maîtres de l'Orge", "Aquablue", "V pour Vendetta", "Les cités obscures", "Gil Jourdan", "Sin City", "Berceuse assassine", "Durango", "Johan et Pirlouit", "Légendes des contrées oubliées", "Yoko Tsuno", "Balade au Bout du monde", "Persepolis", "Le prince de la Nuit", "Servitude", "La vengeance du Comte Skarbek", "La guerre éternelle", "Les schtroumpfs", "S.O.S. Bonheur", "Travis", "Achille Talon", "Sanctuaire", "Jérôme K. Jérôme Bloche", "Le pouvoir des Innocents", "Carmen Mc Callum", "La nef des fous", "Le vent dans les Saules", "Zoo", "Lapinot", "Monster", "La licorne", "Lincoln", "Les bidochon", "I.R.$."]
isbn = ["2-205-00505-7", "2-205-00656-8", "2-205-00753-X", "2-205-00831-5", "2-205-00863-3", "2-205-00904-4", "2-205-00878-1", "2-205-01024-7"]

img = ["vendor/img/jaredd-craig-HH4WBGNyltc-unsplash.jpg",
       "vendor/img/lena-rose-ydHrpfgJNPo-unsplash.jpg",
       "vendor/img/miika-laaksonen-nUL9aPgGvgM-unsplash.jpg",
       "vendor/img/waldemar-brandt-eIOPDU3Fkwk-unsplash.jpg"]

books = []

u = User.create(password: "not_blank", email: "admin@admin.com")

10.times do |i|
  u_last = User.last
  u = User.create(password: "not_blank", email: Faker::Internet.email)
  pm = PrivateMessage.create(sender: u, recipient: u_last, content: Faker::Internet.email)
  pm = PrivateMessage.create(sender: u_last, recipient: u, content: Faker::Internet.email)
  puts "#{i + 1} users created"
end

5.times do |i|
  books = GoogleBooks.search(titles[i])
  books.each_with_index do |book, index|
    puts "#{index + 1} times searched book #{i + 1}"
    unless book.nil?
      if book.categories == "Comics & Graphic Novels"
        puts "#{i + 1} books created"
        picture = "http://books.google.com/books/content?id=#{book.id}&printsec=frontcover&img=1&zoom=0&edge=curl&source=gbs_api"
        b = Book.create(title: book.title, author: book.authors, genre: book.categories, isbn: book.isbn, picture: picture, abstract: book.description, extract: book.description)
        bc = BookCard.create(user_id: User.all.sample.id, book_id: b.id, price: rand(100), to_sell: sell[rand(3)], book_condition: conditions[rand(3)], review: Faker::Quote.famous_last_words)
        bc.book_picture.attach(io: File.open(img.sample), filename: "book_picture.jpg", content_type: "image/jpg")
        p = Punch.create(punchable_id: BookCard.all.sample.id, punchable_type: "BookCard", starts_at: Time.zone.now, ends_at: Time.zone.now, average_time: Time.zone.now, hits: rand(1..10))
      end
    end
  end
end
