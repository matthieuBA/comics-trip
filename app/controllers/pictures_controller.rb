class PicturesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @user.picture.attach(params[:picture])
    redirect_to(book_path(@book))
  end
end
