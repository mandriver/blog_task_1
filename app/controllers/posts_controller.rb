class PostsController < ApplicationController
  def create
    @params = set_params
    @params[:user_id] = User.create_if_not_exists(@params.delete(:login))
    @post = Post.new(@params)
    if @post.save
      render json: @post, status: 200
    else
      render json: @post.errors, status: 422
    end
  end

  private

  def set_params
    params.require(:post).permit(:title, :content, :login, :ip)
  end
end
