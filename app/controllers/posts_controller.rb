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

  def top
    @top = Post.by_rating(params[:id])
    render json: @top, status: 200
  end

  def repeatedly_ip_users
    @result = {}
    Post.repeatedly_ip.each {|i| @result[i.ip.to_s] = i.login }
    render json: @result, status: 200
  end

  private

  def set_params
    params.require(:post).permit(:title, :content, :login, :ip, :quantity)
  end
end
