class BooksController < ApplicationController

    before_action :authenticate_user!

    def new
        @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        flash[:success] = "Le livre a été créé avec succès."
        #redirect_to books_path(@book.id)
      else
        flash[:error] = "Ca sent la vieille trace de pneu pour toi mon coco..."
        render 'new'
      end
    end
    
    def isbn_exist(isbn)
      render 
        if Book.find_by(isbn: isbn).nil?
          Book.new(book_params)
          redirect_to new_book_path
        end
          @book=Book.find_by(isbn: isbn)
        end
    end

      





private
    def book_params
        params.require(:book).permit(:title, :author, :genre, :isbn, :picture, :abstract, :extract)
    end
end

