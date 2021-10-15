class Public::GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    @post_items = @genre.post_items
    # @post_items = PostItem.all.page(params[:page]).per(6)
  end

end
