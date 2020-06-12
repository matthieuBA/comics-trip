class BookCardsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  
  def show
    @book_card = BookCard.find_by(id: params[:id])
    @book_card.punch(request)
  end

  def new
    @book_card = BookCard.new
  end

  def create
    puts "# "*100
    puts current_user.id
    puts "# "*100
    params[:book_card][:user_id] = current_user.id
    @isbn = book_card_params[:book_id]
    if Book.isbn_exist(@isbn)
      @book = Book.find_by(isbn: @isbn)
      params[:book_card][:book_id] = @book.id
      @book_card = BookCard.new(book_card_params)
      if @book_card.save
        flash[:success] = "Le livre a été créé avec succès."
        redirect_to book_card_path(@book_card.id)
      else
        flash[:error] = @book_card.errors.messages
        render 'new'
      end
    else
      flash[:error] = "Le livre portant l'isbn : "+book_card_params[:book_id]+" n'existe pas encore. Merci de créer la fiche du livre associé"
      redirect_to new_book_path
    end
  end
  
  def edit
    @book_card = BookCard.find(params[:id])      

  end

  def update
    @book_card = BookCard.find(params[:id])

    if @book_card.update(book_card_params)
      flash.notice = "Fiche édité avec succés"
      redirect_to book_card_path(params[:id])
    else
      flash.alert = "Impossible d'éditer la fiche"
      render :edit
      flash.alert = nil
    end
  end

  def destroy
    @book_card = BookCard.find(params[:id])
    @book_card.destroy
    redirect_to book_cards_path
  end
  
  private

  def book_card_params
    params.require(:book_card).permit(:user_id, :book_id, :price, :to_sell, :book_condition, :book_picture, :review)
  end
end

