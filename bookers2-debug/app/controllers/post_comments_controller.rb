class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id]) #本来(params[:id])→本のidを探してる?
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = @book.id
    comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    post_comment = @book.post_comments.find(params[:id])
    post_comment.destroy
    # PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
