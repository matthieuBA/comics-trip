User.destroy_all
Book.destroy_all
BookCard.destroy_all
Punch.destroy_all
PrivateMessage.destroy_all
Follow.destroy_all
Tag.destroy_all
Join.destroy_all

conditions = ["parfait", "moyen", "médiocre", "passable"]
sell = ["vente", "achat", "critique"]

titles = ["Blacksad", "La quête de l'oiseau du temps", "Thorgal", "Lanfeust de Troy", "Murena", "Largo Winch", "Spirou et Fantasio", "Le combat ordinaire", "Universal War One", "Aldébaran", "Blake et Mortimer", "Lucky Luke", "Le grand pouvoir du Chninkel", "Le troisième Testament", "Corto Maltese", "Le tueur", "Les tuniques Bleues", "Okko", "Soda", "Magasin général", "Le retour à la terre", "Où le regard ne porte pas...", "Sambre", "Complainte des Landes perdues Heroic", "Les 7 Vies de l'Épervier", "Nikopol", "Bételgeuse", "Valérian", "Le chant des Stryges", "Bouncer", "Le vol du corbeau", "Alim le tanneur", "L'Épervier", "Trolls de Troy", "Golden City", "Walking Dead", "Donjon Zénith", "Aquablue", "Les cités obscures", "Berceuse assassine", "Durango", "Légendes des contrées oubliées", "Balade au Bout du monde", "Le prince de la Nuit", "La vengeance du Comte Skarbek", "Les schtroumpfs", "S.O.S. Bonheur", "Travis", "Achille Talon", "Jérôme K. Jérôme Bloche", "Le pouvoir des Innocents", "Carmen Mc Callum", "La nef des fous", "Lapinot", "Monster", "I.R.$.", "Léonard"]
puts "TITLES nb = "
puts titles.count

out = []
img = ["#{Rails.root}/vendor/img/jaredd-craig-HH4WBGNyltc-unsplash.jpg",
       "#{Rails.root}/vendor/img/lena-rose-ydHrpfgJNPo-unsplash.jpg",
       "#{Rails.root}/vendor/img/miika-laaksonen-nUL9aPgGvgM-unsplash.jpg",
       "#{Rails.root}/vendor/img/waldemar-brandt-eIOPDU3Fkwk-unsplash.jpg"]

books = []
title_tags = ["BD d'exception", "BD dédicacée", "Tirage original"]
img = ["vendor/img/jaredd-craig-HH4WBGNyltc-unsplash.jpg",
       "vendor/img/lena-rose-ydHrpfgJNPo-unsplash.jpg",
       "vendor/img/miika-laaksonen-nUL9aPgGvgM-unsplash.jpg",
       "vendor/img/waldemar-brandt-eIOPDU3Fkwk-unsplash.jpg"]

nb = 0
nb_total = 0
nb_i = -1
bm = 0
bmm = 1
bmt = 0
u = User.create(password: "not_blank", email: "admin@admin.com")

def colorg(color = 32)
  printf "\033[#{color}m"
  yield
  printf "\033[0m"
end

def colorr(color = 31)
  printf "\033[#{color}m"
  yield
  printf "\033[0m"
end

def colorb(color = 34)
  printf "\033[#{color}m"
  yield
  printf "\033[0m"
end

10.times do |i|
  u_last = User.last
  u = User.create(password: "not_blank", email: Faker::Internet.email)
  pm = PrivateMessage.create(sender: u, recipient: u_last, content: Faker::Internet.email)
  pm = PrivateMessage.create(sender: u_last, recipient: u, content: Faker::Internet.email)
  puts "#{i + 1} users created"
end

titles.count.times do |o|
  time = Benchmark.measure {
    puts titles[o]
    title = titles[o]
    books = GoogleBooks.search("#{titles[o]}", { :country => "fr", :count => 4, :api_key => "AIzaSyAiQSB1-DXCypy2LsM-TANMeTLAUurevYk" })
    books.each_with_index do |book, index|
      nb_total += 1
      puts "#{index + 1} times searched book #{o + 1} with #{nb_total} search requests on #{nb} created books"
      unless book.nil?
        if book.language == "fr"
          p book.categories
          colorr { p book.language }
          if book.categories.downcase.include?("comic book") || book.categories.downcase.include?("comic strip") || book.categories.downcase.include?("graphic novel") || book.categories.downcase.include?("bande dessiné")
            colorg { p book.categories }
            picture = "https://books.google.com/books/content?id=#{book.id}&printsec=frontcover&img=1&zoom=0"
            thumbnail = "https://books.google.com/books/content?id=#{book.id}&printsec=frontcover&img=1&zoom=2"
            colorg { p picture }
            b = Book.create(title: book.title, author: book.authors, genre: book.categories, isbn: book.isbn, picture: picture, abstract: book.description, extract: book.description)
            to_sell = sell[rand(3)]
            colorg { p to_sell }
            case to_sell
            when "vente"
              bc = BookCard.create(user_id: User.all.sample.id, book_id: b.id, price: rand(100), to_sell: to_sell, book_condition: conditions[rand(3)], book_picture_seed: thumbnail)
            when "achat"
              bc = BookCard.create(user_id: User.all.sample.id, book_id: b.id, to_sell: to_sell, book_picture_seed: thumbnail)
            when "critique"
              bc = BookCard.create(user_id: User.all.sample.id, book_id: b.id, to_sell: to_sell, review: Faker::Quote.famous_last_words, book_picture_seed: thumbnail)
            end
            #BookCard.last.book_picture.attach(io: File.open(img.sample), filename: "book_picture.jpg", content_type: "image/jpg")
            p = Punch.create(punchable_id: BookCard.all.sample.id, punchable_type: "BookCard", starts_at: Time.zone.now, ends_at: Time.zone.now, average_time: Time.zone.now, hits: rand(1..10))
            nb += 1
            puts "#{nb} books created"
            out << titles[o]
            puts "added #{book.title} from index #{o}"
          end
        end
      end
    end
  }
  puts "ETA = #{((titles.count - o) * bmm) / 60} minutes remaining or #{((titles.count - o) * bmm) / 3600} hours"
  puts "RST = #{(titles.count - o)}"
  bmt += time.real
  bmm = bmt / (o + 1)
  colorr { puts "REAL = #{time.real}" }
  puts "MOY = #{bmm}"
  puts time
end
puts "TOTAL = #{(bmt) / 60} minutes remaining or #{(bmt) / 3600} hours"
p out

tab = User.all
5.times do |i|
  fl = Follow.create(follower_id: tab[i].id, followee_id: tab[i + 1].id)
  puts "#{i + 1} follow created"
end

title_tags.count.times do |i|
  tag = Tag.create(title: title_tags[i])
  puts "Tag n°#{i + 1} created"
  join = Join.create(book_card_id: BookCard.all.sample.id, tag_id: Tag.last.id)
end
