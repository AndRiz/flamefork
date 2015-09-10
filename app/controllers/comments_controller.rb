class CommentsController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def create
    # build a new comment from the information contained in the "new comment" form
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:success] = 'Comment created!'
      redirect_to :back
    else
      flash[:danger] = 'ERROR: Title must be present and longer than 5 chars content must be present and not longer than 500 chars'
      redirect_to :back
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end


  private

  def correct_user
    # does the user have a comment with the given id?
    @comment = Comment.find(params[:id])
    #find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to root_url if @comment.nil?
  end

end