class BooksController < ApplicationController

  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "Le livre a été créé avec succès."
      redirect_to book_path(@book.id)
    else
      flash[:error] = "La création de livre a échoué"
      render 'new'
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :author, :genre, :isbn, :picture, :abstract, :extract)
    end
end
