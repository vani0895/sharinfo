class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Comment added successfully"
    else
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
