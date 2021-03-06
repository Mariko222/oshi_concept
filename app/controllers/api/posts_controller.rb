class Api::PostsController < ApplicationController
  before_action :authenticate!
  before_action :set_post, only: %i[destroy]

  def index
    posts = current_user.posts.all
    render json: posts, each_serializer: PostSerializer
  end

  def create
    mygenre = Mygenre.find(params[:mygenre_id])
    post = mygenre.posts.build(webpage_params) if params[:type] == 'webpage'
    post = mygenre.posts.build(post_params) if params[:type] == 'twitter'

    if post.save
      render json: post
    else
      raise ActiveRecord::RecordNotFound, post.errors.full_messages
    end
  end

  def destroy
    @post.destroy!
    render json: @post
  end

  private

  def post_params
    params.require(:post).permit(:category, :type, :url, :mygenre_id)
  end

  def webpage_params
    agent = Mechanize.new
    page = agent.get(params[:post][:url])
    ogp = page.at("meta[property='og:image']").try(:[], :content)
    params.require(:post).permit(:category, :type, :url, :mygenre_id).merge(title: page.title, image: ogp)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
