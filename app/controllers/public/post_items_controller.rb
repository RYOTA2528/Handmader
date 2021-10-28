class Public::PostItemsController < ApplicationController
  before_action :authenticate_user!

  def new
   @post_item = PostItem.new
   @genres= Genre.all
  end

  def create
   @post_item = PostItem.new(post_item_params)
   @post_item.user_id = current_user.id
   @post_item.genre_ids = params[:post_item][:genre_ids]
    if @post_item.save
      flash[:success] = "投稿に成功しました"
      redirect_to public_post_item_path(@post_item)
    else
      render :new
    end
  end

  def show
    @post_item = PostItem.find(params[:id])
    @comment = Comment.new
  end

  def index
     @genres= Genre.all
     @search = PostItem.ransack(params[:q])
     @post_items = @search.result
     @post_items =@post_items.page(params[:page]).per(6)
  end

  def edit
    @post_item = PostItem.find(params[:id])
  end

  def update
    @post_item = PostItem.find(params[:id])
    if params[:post_item][:image_ids]
      params[:post_item][:image_ids].each do |image_id|
        image = @post_item.images.find(image_id)
        image.purge
      end
    end
    if @post_item.update(post_item_params)
      flash[:notice]='作品の編集が完了しました'
       redirect_to public_post_item_path(@post_item)
    else
      render :edit
    end
  end

  def destroy
    @post_item = PostItem.find(params[:id])
    @post_item.images.each do |image|
      image.purge
    end
    @post_item.destroy
    flash[:success] = "作成しました"
    redirect_to public_user_path(current_user)
  end

  def search
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @post_items = PostItem.all
    @post_items = PostItem.limit(10).order("created_at DESC")
  end
  # お気に入り数ランキング
  def ranking
    @favorite_ranks = PostItem.find(Favorite.group(:post_item_id).order('count(post_item_id)desc').limit(5).pluck(:post_item_id))
    @weekly_ranks = PostItem.find(Favorite.group(:post_item_id).where(created_at: Time.current.all_month).order('count(post_item_id)desc').limit(5).pluck(:post_item_id))
    @daily_ranks = PostItem.find(Favorite.group(:post_item_id).where(created_at: Time.current.all_day).order('count(post_item_id)desc').limit(5).pluck(:post_item_id))
    @post_items = PostItem.order("created_at DESC")
  end

  private

  def post_item_params
   params.require(:post_item).permit(:user_id,:avatar,:name,:text, images: [], genre_ids: [])
  end
end