class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.where(book_card_id: params[:book_card_id])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @params = params
    @book_card = BookCard.find(params[:book_card_id])
    @comment = @book_card.comments.new(content: params[:content])
    @comment.user_id = current_user.id
    @comment.book_card_id = @book_card.id
    if @comment.save
      redirect_to book_card_path(@book_card.id)
    else
      flash[:error] = "commentaire non sauvegardé #{@comment.errors.messages}"
      render ("new")
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user_id == current_user.id
      @comment = Comment.find(params[:id])
      if @comment.delete
        flash[:success] = "commentaire supprimé"
        redirect_to book_card_path(@comment.book_card_id)
      end
    else
      flash[:error] = "commentaire non suprrimé #{@comment.errors.messages}"
      redirect_to book_card_path(@comment.book_card_id)
    end
  end


  def edit
    comment = Comment.find(params[:id])

    if comment.user_id == current_user.id
      @comment = Comment.find(params[:id])
    else
      flash[:error] = "ce n'est pas votre commentaire #{comment.errors.messages}"
      redirect_to book_card_path(comment.book_card_id)
    end

  end

  def update
    comment = Comment.find(params[:id])
    if comment.user_id == current_user.id
      @comment = Comment.find(params[:id])
      if @comment.update(content: params[:content])
        redirect_to book_card_comment_path(@comment.book_card_id, @comment.id)
      else
        flash[:error] = "commentaire non mis à jour #{@comment.errors.messages}"
        render "edit"
      end
    else
      flash[:error] = "commentaire non mis à jour #{@comment.errors.messages}"
      redirect_to book_card_comment_path(@comment.book_card_id, @comment.id)
    end
  end


end
