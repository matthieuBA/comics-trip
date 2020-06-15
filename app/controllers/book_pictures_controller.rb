class BookPicturesController < ApplicationController
  def create
    @book_card = BookCard.find(params[:book_card_id])
    @book_card.book_picture.attach(params[:book_picture])
    redirect_to(book_card_path(@book_card))
  end
end
