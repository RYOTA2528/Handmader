class Public::GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    @post_items = @genre.post_items
  end

end
