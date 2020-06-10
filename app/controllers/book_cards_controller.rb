class BookCardsController < ApplicationController
  
  #before_action :isbn_exist, only: [:create]

  def show
    @book_card = BookCard.find_by(id: params[:id])
  end

  def new
    @book_card = BookCard.new
  end

  def create
    @isbn = book_card_params[:book_id]

    # puts " # "*50
    # puts book_card_params[:book_id]
    # puts " # "*50

    if Book.isbn_exist(@isbn)
      puts "ok tout marche"
      @book = Book.find_by(isbn: @isbn)

      puts " # "*50
      puts @book.id
      puts " # "*50

      params[:book_card][:book_id] = @book.id

      puts " # "*50
      puts book_card_params[:book_id] 
      puts " # "*50

      @book_card = BookCard.new(book_card_params)

      if @book_card.save
        flash[:success] = "Le livre a été créé avec succès."
        redirect_to book_cards_path(@book_card.id)
      else
        flash[:error] = @book_card.errors.messages
        render 'new'
      end
    else
      puts "rien trouvé"
      redirect_to new_book_path
    end

  end

  def destroy
    @book_card = BookCard.find_by(id: params[:id])
    @book_card.destroy
    redirect_to book_cards_path
  end
  
  private
  def book_card_params
    params.require(:book_card).permit(:user_id, :book_id, :price, :to_sell, :book_condition, :book_picture, :review)
  end
end
