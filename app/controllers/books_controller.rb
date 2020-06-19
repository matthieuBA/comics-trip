class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.page(params[:page]).per(15)
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "Le livre a été créé avec succès. Merci pour l'ajout!"
      redirect_to book_path(@book.id)
    else
      flash[:error] = "Essaye encore! La création de livre a échoué"
      render "new"
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn, :picture, :abstract, :extract)
  end
end
