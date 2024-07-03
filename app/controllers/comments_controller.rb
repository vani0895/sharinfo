class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment
    else
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
