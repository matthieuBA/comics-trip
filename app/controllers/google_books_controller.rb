class GoogleBooksController < ApplicationController
  def index
  end

  def show
  end

  def search  
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else  
      @parameter = params[:search]
      puts "# "*100
      puts params[:search]
      puts "# "*100
      @results = books = GoogleBooks.search(params[:search]) 
    end  
  end
end
