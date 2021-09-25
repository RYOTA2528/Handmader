class Public::PostItemsController < ApplicationController
  before_action :authenticate_user!
  def new
   @post_item = PostItem.new
   @genres= Genre.all
  end

  def create
   @post_item = PostItem.new(post_item_params)
   @post_item.user_id = current_user.id
    if @post_item.save
      flash[:success] = "投稿に成功しました"
      redirect_to public_post_item_path(@post_item)
    else
      render :new
    end
  end

  def show
    @post_item = PostItem.find(params[:id])
    # PostImageモデル作成後の記述。下記のようにすると現在のユーザーの投稿のみを取得できる
    # @post_items = @user.post_items.page(params[:page]).reverse_order
  end

  def index
    @post_items = PostItem.all
  end

  def edit
    @post = PostItem.find(params[:id])
  end

  def update
    @post_item = PostItem.find(current_user.id)
    if @post_item.update(post_item_params)
      # redirect_to public_user_path(@user.id)
      flash[:notice]='プロフィールが登録されました。'
    else
      render :edit
    end
  end

  def destroy
    @post_item = PostItem.find(params[:id])
    @post_item.destroy
    flash[:success] = "作成しました"
    redirect_to public_user_path(@post_item)
  end

  private

  def post_item_params
   params.require(:post_item).permit(:user_id,:name,:text, images: [], genre_ids: [])
  end
end