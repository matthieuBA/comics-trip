class BookCardsController < ApplicationController
  before_create :isbn_exist!

  def show
    @book_card = BookCard.find_by(id: params[:id])
  end

  def new
    @book_card = BookCard.new
  end

  def create
    @book_card = BookCard.new(book_card_params)
    if @book_card.save
      flash[:success] = "Le livre a été créé avec succès."
      redirect_to book_cards_path(@book.id)
    else
      flash[:error] = "Ca sent la vieille trace de pneu pour toi mon coco..."
      render 'new'
    end
  end

  private
  def book_card_params
      params.require(:book_card).permit(:user_id, :book_id, :price, :to_sell, :book_condition, :book_picture, :review)
  end
end
