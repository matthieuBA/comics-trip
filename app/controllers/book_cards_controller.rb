class BookCardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def show
    @book_card = BookCard.find_by(id: params[:id])
    @book_card.punch(request)
    @user = User.find_by(id: @book_card.user_id)
    @book = Book.find_by(id: @book_card.book_id)
  end

  def new
    @book_card = BookCard.new
    @books = Book.all
    @type = params[:type]
    puts @type
  end

  def create
    params[:book_card][:user_id] = current_user.id
    @isbn = book_card_params[:book_id]
    if Book.isbn_exist(@isbn)
      @book = Book.find_by(isbn: @isbn)
      params[:book_card][:book_id] = @book.id
      @book_card = BookCard.new(book_card_params)
      if @book_card.save
        add_tag
        flash[:success] = "Merci pour l'ajout! Le livre a été créé avec succès."
        redirect_to book_card_path(@book_card.id)
      else
        flash[:error] = @book_card.errors.messages
        render "new"
      end
    else
      flash[:error] = "Le livre portant l'isbn : " + book_card_params[:book_id] + " n'existe pas encore. Merci de créer la fiche du livre associé"
      redirect_to new_book_path
    end
  end

  def edit
    @book_card = BookCard.find(params[:id])
  end

  def update
    @book_card = BookCard.find(params[:id])

    if @book_card.update(book_card_params)
      flash.notice = "Fiche éditée avec succés"
      redirect_to book_card_path(params[:id])
    else
      flash.alert = "Impossible d'éditer la fiche"
      render :edit
    end
  end

  def destroy
    @book_card = BookCard.find(params[:id])
    @book_card.destroy
    redirect_to book_cards_path
  end

  def index
    if params[:search]
      @title = "Résultat de votre recherche"
      @book_cards = BookCard.search(params[:search])
      if @book_cards.empty?
        @book_cards = BookCard.all
        flash.notice = "Aucune recherche ne correspond à vos critères"
        render :index
      else
        @book_cards
      end
    elsif params[:type] && params[:user].nil?
      @title = "Liste #{params[:type]} filtrée"
      @book_cards = BookCard.where(to_sell: params[:type]).page(params[:page]).per(20)
      if @book_cards.empty?
        @book_cards = BookCard.page(params[:page]).per(20)
        flash.notice = "Aucune annonce ne correspond à vos critères"
        render :index
      else
        @book_cards
      end
    elsif params[:type] && params[:user]
      @title = "Liste #{params[:type]} de l' utilisateur #{User.find_by(id: params[:user]).email}"
      @book_cards = BookCard.where(to_sell: params[:type], user_id: params[:user]).page(params[:page]).per(20)
      if @book_cards.empty?
        @book_cards = BookCard.page(params[:page]).per(20)
        flash.notice = "Aucune annonce ne correspond à vos critères"
        render :index
      else
        @book_cards
      end
    elsif params[:type].nil? && params[:user]
      @title = "Liste de l' utilisateur #{User.find_by(id: params[:user]).email}"
      @book_cards = BookCard.where(user_id: params[:user]).page(params[:page]).per(20)
      if @book_cards.empty?
        @book_cards = BookCard.page(params[:page]).per(20)
        flash.notice = "Aucune annonce ne correspond à vos critères"
        render :index
      else
        @book_cards
      end
    else
      @title = "Liste complète"
      @book_cards = BookCard.page(params[:page]).per(20)
    end
  end

  private

  def book_card_params
    params.require(:book_card).permit(:user_id, :book_id, :price, :to_sell, :book_condition, :book_picture, :review)
  end

  def add_tag
    tag = Tag.find_by(title: params[:book_card][:tag])
    Join.create(book_card_id: BookCard.last.id, tag_id: tag.id)
  end
end
