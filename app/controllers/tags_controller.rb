class TagsController < ApplicationController

  def create
    tag = Tag.find_by(title:params[:title])
    Join.create(book_card_id:params[:id], tag_id:tag.id)
  end
end
