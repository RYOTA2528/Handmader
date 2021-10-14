class Public::CommentsController < ApplicationController

  def create
   @post_item = PostItem.find(params[:post_item_id])
   @comment = @post_item.comments.build(comment_params)
   @comment.user_id = current_user.id
   @comment.save
   redirect_to public_post_item_path(@post_item)
  end

  def destroy
   @comment = Comment.find_by(id: params[:id]).destroy
   redirect_to public_post_item_path(params[:post_item_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_item_id, :user_id)
  end

end
