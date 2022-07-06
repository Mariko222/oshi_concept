class Api::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  before_action :authenticate!

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    binding.pry
    mygenre = Mygenre.find(params[:mygenre_id])
    @post = mygenre.posts.build(post_params)

    if @post.save
      render json: @post
    else
      render json: @post.errors, status: :bad_request
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :bad_request
    end
  end

  def destroy
    @post.destroy!
    render json: @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:category, :type, :url, :mygenre_id)
  end
end
