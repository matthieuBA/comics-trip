class BookCardsController < ApplicationController

  def show
    @book_card = BookCard.find_by(id: params[:id])
  end
end
