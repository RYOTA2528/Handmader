class Admin::GenresController < ApplicationController
   before_action :authenticate_admin!
  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path(@genre)
      flash[:notice]='新たにジャンルが登録されました。'
    else
      render "admin/genres/new"
    end
  end

  def index
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path(@genres)
      flash[:notice]='ジャンルが変更されました。'
    else
      render :edit
    end
  end

  private

   def genre_params
     params.require(:genre).permit(:name, :image)
   end

end