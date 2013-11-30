class CommentsController < ApplicationController
  def create
    @lodge = Lodge.find(params[:lodge_id])
    @comment = @lodge.comments.create(params[:comment].permit(:email, :price, :quality, :message))
    redirect_to lodge_path(@lodge)
  end
end
